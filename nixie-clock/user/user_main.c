#include "ets_sys.h"
#include "osapi.h"
#include "gpio16.h"
#include "nodemcu_gpio.h"
#include "os_type.h"
#include "user_config.h"

#define user_procTaskPrio 0
#define user_procTaskQueueLen 1
os_event_t user_procTaskQueue[user_procTaskQueueLen];


typedef enum
{
	CLOCK_VIEW,
	CLOCK_SET_HR,
	CLOCK_SET_MIN,
} clock_state_t;

typedef struct
{
	clock_state_t state;
	unsigned hour;
	unsigned minute;
	unsigned digit_current;
	unsigned rot_up;
	unsigned rot_down;
	uint32 pin_digit_clock;
	uint32 pin_digit_data;
	uint32 pin_digit_latch;
	uint32 pin_button;
	uint32 pin_rot_clk;
	uint32 pin_rot_data;
	uint32 id_button;
	uint32 id_rot_clk;
	volatile os_timer_t timer_digit;
	volatile os_timer_t timer_tmp;
} nixie_clock_t;


static unsigned ICACHE_FLASH_ATTR rollover_add(unsigned x, int y, unsigned b)
{
	x += b + y;
	return x % b;
}

static void ICACHE_FLASH_ATTR shift_out_16(uint16 data, uint32 gpio_clock, uint32 gpio_data, uint32 gpio_latch)
{
	// Bits get shifted onto the register outputs in the following order:
	// LSB of the lower byte goes to Q7, 2nd register
	// MSB of the lower byte goes to Q0, 2nd register
	// LSB of the upper byte goes to Q7, 1st register
	// MSB of the upper byte goes to Q0, 1st register

	// No delays are used, the 74HC595 is fast enough to handle this

	gpio_output_set(0, gpio_latch, gpio_latch, 0);

	unsigned i;
	for (i = 0; i < 16; ++i, data >>= 1)
	{
		uint16 bit = data & 1;
		if (bit) gpio_output_set(gpio_data, gpio_clock, gpio_clock | gpio_data, 0);
		else gpio_output_set(0, gpio_clock | gpio_data, gpio_clock | gpio_data, 0);
		gpio_output_set(gpio_clock, 0, gpio_clock, 0);
		gpio_output_set(0, gpio_data, gpio_data, 0);
	}

	gpio_output_set(gpio_latch, 0, gpio_latch, 0);
}

static uint16 ICACHE_FLASH_ATTR encode_digit(uint16 digit, uint16 anodes)
{
	anodes <<= 8;

	// BCD positions on 2nd shift register pins:
	// Q7 -> A
	// Q6 -> D
	// Q5 -> B
	// Q4 -> C
	// A is BCD LSB
	uint16 bcd = (digit & 1) | (digit & 8) >> 2 | (digit & 6) << 1;

	return anodes | bcd;
}

static uint16 ICACHE_FLASH_ATTR encode_state(clock_state_t state)
{
	switch (state)
	{
		case CLOCK_SET_HR: return 1 << 4;
		case CLOCK_SET_MIN: return 1 << 5;
		default: return 0;
	}
}

static unsigned digit_tmp = 0;

void ICACHE_FLASH_ATTR timer_display_test(void *arg)
{
	static uint16 num = 0;

	nixie_clock_t *clock = (nixie_clock_t*)arg;

	uint16 digit_data = encode_digit(num % 10, 1 << num / 2 % 4);
	shift_out_16(digit_data, clock->pin_digit_clock, clock->pin_digit_data, clock->pin_digit_latch);

	num++;
}

void ICACHE_FLASH_ATTR timer_clock(void *arg)
{
	nixie_clock_t *clock = (nixie_clock_t*)arg;

	if (clock->state != CLOCK_VIEW)
	{
		int delta = 0;
		if (clock->rot_up >= 2)
		{
			delta = 1;
			clock->rot_up = 0;
		}
		else if (clock->rot_down >= 2)
		{
			delta = -1;
			clock->rot_down = 0;
		}

		if (delta && clock->state == CLOCK_SET_HR) clock->hour = rollover_add(clock->hour, delta, 24);
		else if (delta && clock->state == CLOCK_SET_MIN) clock->minute = rollover_add(clock->minute, delta, 60);

		if (delta) {
			os_printf("delta: %d, state: %d %u:%u\n", delta, clock->state, clock->hour, clock->minute);
		}
	}

	uint16 digit = 0;
	switch (clock->digit_current)
	{
		case 0: digit = clock->hour / 10; break;
		case 1: digit = clock->hour % 10; break;
		case 2: digit = clock->minute / 10; break;
		case 3: digit = clock->minute % 10; break;
	}

	uint16 data = encode_digit(digit, 1 << clock->digit_current);
	data |= encode_state(clock->state);
	shift_out_16(data, clock->pin_digit_clock, clock->pin_digit_data, clock->pin_digit_latch);

	clock->digit_current = clock->digit_current + 1 & 3;
}

void ICACHE_FLASH_ATTR timer_tmp(void *arg)
{
	nixie_clock_t *clock = (nixie_clock_t*)arg;

	if (clock->state == CLOCK_VIEW)
	{
		clock->minute++;
		if (clock->minute >= 60)
		{
			clock->minute = 0;
			clock->hour = rollover_add(clock->hour, 1, 24);
		}
	}
}

static void ICACHE_FLASH_ATTR timer_kickoff(volatile os_timer_t *timer, os_timer_func_t *fn, unsigned delay, void *arg)
{
	os_timer_disarm(timer);
	os_timer_setfn(timer, fn, arg);
	os_timer_arm(timer, delay, 1);
}

void nixie_gpio_interrupt(void *arg)
{
	nixie_clock_t *clock = (nixie_clock_t*)arg;

	uint32 gpio_status;
	gpio_status = GPIO_REG_READ(GPIO_STATUS_ADDRESS);

	if (gpio_status & clock->pin_button)
	{
		gpio_pin_intr_state_set(clock->id_button, GPIO_PIN_INTR_DISABLE);

		switch (clock->state)
		{
			case CLOCK_VIEW:
				gpio_output_set(0, NM_BIT_LED, NM_BIT_LED, 0);
				clock->state = CLOCK_SET_HR;
				break;
			case CLOCK_SET_HR:
				gpio_output_set(NM_BIT_LED, 0, NM_BIT_LED, 0);
				gpio16_output_set(0);
				clock->state = CLOCK_SET_MIN;
				break;
			case CLOCK_SET_MIN:
				gpio16_output_set(1);
				clock->state = CLOCK_VIEW;
				break;
		}

		os_delay_us(1000);

		GPIO_REG_WRITE(GPIO_STATUS_W1TC_ADDRESS, gpio_status & clock->pin_button);
		gpio_pin_intr_state_set(clock->id_button, GPIO_PIN_INTR_POSEDGE);
	}

	if (gpio_status & clock->pin_rot_clk)
	{
		// Both edges are observed and inc/decrements are made only when consistent
		// direction is observed in both cases in order to minimize jitter.

		gpio_pin_intr_state_set(clock->id_rot_clk, GPIO_PIN_INTR_DISABLE);
		uint32 input = gpio_input_get();
		uint32 rot_data = input & clock->pin_rot_clk ^ (input & clock->pin_rot_data) >> 1;

		if (rot_data)
		{
			clock->rot_up++;
			clock->rot_down = 0;
		}
		else
		{
			clock->rot_up = 0;
			clock->rot_down++;
		}

		GPIO_REG_WRITE(GPIO_STATUS_W1TC_ADDRESS, gpio_status & clock->pin_rot_clk);
		gpio_pin_intr_state_set(clock->id_rot_clk, GPIO_PIN_INTR_ANYEDGE);
	}
}

static void ICACHE_FLASH_ATTR nixie_clock_init(nixie_clock_t *clock)
{
	clock->state = CLOCK_VIEW;
	clock->hour = 12;
	clock->minute = 34;
	clock->digit_current = 0;
	os_timer_disarm(&clock->timer_digit);

	// Outputs
	PIN_FUNC_SELECT(NM_NAME1, NM_FUNC1);  // clock - SHCP
	PIN_FUNC_SELECT(NM_NAME2, NM_FUNC2);  // latch - STCP
	PIN_FUNC_SELECT(NM_NAME3, NM_FUNC3);  // data  - DS
	clock->pin_digit_clock = NM_BIT1;
	clock->pin_digit_latch = NM_BIT2;
	clock->pin_digit_data = NM_BIT3;
	uint32 set_output = NM_BIT1 | NM_BIT2 | NM_BIT3;

	// Inputs
	PIN_FUNC_SELECT(NM_NAME9, NM_FUNC9);  PIN_PULLUP_EN(NM_NAME9);
	PIN_FUNC_SELECT(NM_NAME6, NM_FUNC6);  PIN_PULLUP_EN(NM_NAME6);
	PIN_FUNC_SELECT(NM_NAME7, NM_FUNC7);  PIN_PULLUP_EN(NM_NAME7);
	clock->pin_button = NM_BIT9;
	clock->pin_rot_clk = NM_BIT6;
	clock->pin_rot_data = NM_BIT7;
	clock->id_button = NM_ID9;
	clock->id_rot_clk = NM_ID6;
	uint32 set_innput = NM_BIT9 | NM_BIT5 | NM_BIT7;
	gpio_output_set(0, set_output, set_output, set_innput);

	// Interrupts
	ETS_GPIO_INTR_DISABLE();
	ETS_GPIO_INTR_ATTACH(nixie_gpio_interrupt, clock);
	GPIO_REG_WRITE(GPIO_STATUS_W1TC_ADDRESS, clock->pin_button | clock->pin_rot_clk);
	gpio_pin_intr_state_set(clock->id_button, GPIO_PIN_INTR_POSEDGE);
	gpio_pin_intr_state_set(clock->id_rot_clk, GPIO_PIN_INTR_ANYEDGE);
	ETS_GPIO_INTR_ENABLE();

	// LEDs
	PIN_FUNC_SELECT(NM_NAME_LED, NM_FUNC_LED);
	gpio_output_set(NM_BIT_LED, 0, NM_BIT_LED, 0);
	gpio16_output_conf();
	gpio16_output_set(1);
}

static void ICACHE_FLASH_ATTR user_procTask(os_event_t *events)
{
	os_delay_us(10);
}

void ICACHE_FLASH_ATTR user_init()
{
	static nixie_clock_t nixie_clock;

	gpio_init();
	uart_div_modify(0, UART_CLK_FREQ / 115200);
	os_printf("Nixie clock initialized!\n");

	nixie_clock_init(&nixie_clock);

	timer_kickoff(&nixie_clock.timer_digit, timer_clock, 1, &nixie_clock);
	// timer_kickoff(&nixie_clock.timer_digit, timer_display_test, 500, &nixie_clock);
	timer_kickoff(&nixie_clock.timer_tmp, timer_tmp, 1000, &nixie_clock);

	system_os_task(user_procTask, user_procTaskPrio, user_procTaskQueue, user_procTaskQueueLen);
}
