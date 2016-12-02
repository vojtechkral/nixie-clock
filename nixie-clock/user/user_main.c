#include "ets_sys.h"
#include "osapi.h"
#include "nodemcu_gpio.h"
#include "os_type.h"
#include "user_config.h"

#define user_procTaskPrio 0
#define user_procTaskQueueLen 1
os_event_t user_procTaskQueue[user_procTaskQueueLen];


typedef struct
{
	unsigned digits[4];
	unsigned digit_current;
	uint32 pin_digit_clock,
		pin_digit_data,
		pin_digit_latch,
		pin_button,
		pin_rot_clk,
		pin_rot_data;
	volatile os_timer_t timer_digit;
} nixie_clock_t;


static void ICACHE_FLASH_ATTR shift_out_16(uint16 data, uint32 gpio_clock, uint32 gpio_data, uint32 gpio_latch)
{
	// Bits get shifted onti the register outputs in the following order:
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

static unsigned digit_tmp = 0;

void ICACHE_FLASH_ATTR timer_display_test(void *arg)
{
	static uint16 digit = 0;

	os_printf("timer_display_test()!\n");

	nixie_clock_t *clock = (nixie_clock_t*)arg;

	uint16 digit_data = encode_digit(digit, 0xf);
	shift_out_16(digit_data, clock->pin_digit_clock, clock->pin_digit_data, clock->pin_digit_latch);

	digit = (digit + 1) % 10;
}

void ICACHE_FLASH_ATTR timer_clock_digit(void *arg)
{
	nixie_clock_t *clock = (nixie_clock_t*)arg;

	gpio_output_set(0, NM_BIT_LED, NM_BIT_LED, 0);

	uint16 digit = clock->digits[clock->digit_current];
	uint16 digit_data = encode_digit(digit, 1 << clock->digit_current);
	os_printf("digit/data: %u %u 0x%x\n", clock->digit_current, digit, digit_data);
	shift_out_16(digit_data, clock->pin_digit_clock, clock->pin_digit_data, clock->pin_digit_latch);

	clock->digit_current = (clock->digit_current + 1) % 4;
	os_delay_us(400 * 1000);
	gpio_output_set(NM_BIT_LED, 0, NM_BIT_LED, 0);
}

static void ICACHE_FLASH_ATTR timer_kickoff(volatile os_timer_t *timer, os_timer_func_t *fn, unsigned delay, void *arg)
{
	os_timer_disarm(timer);
	os_timer_setfn(timer, fn, arg);
	os_timer_arm(timer, delay, 1);
}

void ICACHE_FLASH_ATTR nixie_gpio_interrupt(void *arg)
{
	// nixie_clock_t *clock = (nixie_clock_t*)arg;

	uint32 gpio_status;
	gpio_status = GPIO_REG_READ(GPIO_STATUS_ADDRESS);

	os_printf("Interrupt!\n");

	if (gpio_status & NM_BIT5)
	{
		gpio_pin_intr_state_set(NM_BIT5, GPIO_PIN_INTR_DISABLE);

		gpio_output_set(0, NM_BIT_LED, NM_BIT_LED, 0);
		os_delay_us(250 * 1000);
		gpio_output_set(NM_BIT_LED, 0, NM_BIT_LED, 0);

		GPIO_REG_WRITE(GPIO_STATUS_W1TC_ADDRESS, gpio_status & NM_BIT5);
		gpio_pin_intr_state_set(NM_BIT5, GPIO_PIN_INTR_NEGEDGE);
	}
	else if (gpio_status & NM_BIT6)
	{
		uint32 input = gpio_input_get();

		gpio_pin_intr_state_set(NM_ID6, GPIO_PIN_INTR_DISABLE);

		// uint32 rot_data = !!(input & NM_BIT6) ^ !!(input & NM_BIT7);
		// uint32 led_bit = rot_data ? NM_BIT10 : NM_BIT_LED;
		// uint32 led_bit_set = rot_data ? NM_BIT10 : 0;
		// uint32 led_bit_clear = rot_data ? 0 : NM_BIT_LED;
		// gpio_output_set(led_bit_set, led_bit_clear, led_bit, 0);
		// os_delay_us(40 * 1000);
		// gpio_output_set(led_bit_clear, led_bit_set, led_bit, 0);

		if (input & NM_BIT7) gpio_output_set(NM_BIT10, 0, NM_BIT10, 0);
		else gpio_output_set(0, NM_BIT10, NM_BIT10, 0);

		gpio_output_set(0, NM_BIT_LED, NM_BIT_LED, 0);
		os_delay_us(40 * 1000);
		gpio_output_set(NM_BIT_LED, 0, NM_BIT_LED, 0);

		GPIO_REG_WRITE(GPIO_STATUS_W1TC_ADDRESS, gpio_status & NM_BIT6);
		gpio_pin_intr_state_set(NM_ID6, GPIO_PIN_INTR_NEGEDGE);
	}
}

static void ICACHE_FLASH_ATTR nixie_clock_init(nixie_clock_t *clock)
{
	clock->digits[0] = 1;
	clock->digits[1] = 2;
	clock->digits[2] = 3;
	clock->digits[3] = 8;
	clock->digit_current = 0;
	os_timer_disarm(&clock->timer_digit);

	// Outputs
	PIN_FUNC_SELECT(NM_NAME1, NM_FUNC1);  // clock - SHCP
	PIN_FUNC_SELECT(NM_NAME2, NM_FUNC2);  // latch - STCP
	PIN_FUNC_SELECT(NM_NAME3, NM_FUNC3);  // data  - DS
	PIN_FUNC_SELECT(NM_NAME10, NM_FUNC10);  // TMP - LED
	clock->pin_digit_clock = NM_BIT1;
	clock->pin_digit_latch = NM_BIT2;
	clock->pin_digit_data = NM_BIT3;
	uint32 set_output = NM_BIT1 | NM_BIT2 | NM_BIT3 | NM_BIT10;

	// Inputs
	PIN_FUNC_SELECT(NM_NAME5, NM_FUNC5);  PIN_PULLUP_EN(NM_NAME5);
	PIN_FUNC_SELECT(NM_NAME6, NM_FUNC6);  PIN_PULLUP_EN(NM_NAME6);
	PIN_FUNC_SELECT(NM_NAME7, NM_FUNC7);  PIN_PULLUP_EN(NM_NAME7);
	clock->pin_button = NM_BIT5;
	clock->pin_rot_clk = NM_BIT5;
	clock->pin_rot_data = NM_BIT5;
	uint32 set_innput = NM_BIT5 | NM_BIT6 | NM_BIT7;
	gpio_output_set(0, set_output, set_output, set_innput);

	// Interrupts
	ETS_GPIO_INTR_DISABLE();
	ETS_GPIO_INTR_ATTACH(nixie_gpio_interrupt, clock);
	GPIO_REG_WRITE(GPIO_STATUS_W1TC_ADDRESS, NM_BIT5 | NM_BIT6);
	gpio_pin_intr_state_set(NM_ID5, GPIO_PIN_INTR_NEGEDGE);
	gpio_pin_intr_state_set(NM_ID6, GPIO_PIN_INTR_NEGEDGE);
	ETS_GPIO_INTR_ENABLE();

	// LED off
	PIN_FUNC_SELECT(NM_NAME_LED, NM_FUNC_LED);
	gpio_output_set(NM_BIT_LED, 0, NM_BIT_LED, 0);
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

	// timer_kickoff(&nixie_clock.timer_digit, timer_clock_digit, 40, &nixie_clock);
	// timer_kickoff(&nixie_clock.timer_digit, timer_clock_digit, 1000, &nixie_clock);
	timer_kickoff(&nixie_clock.timer_digit, timer_display_test, 1000, &nixie_clock);

	system_os_task(user_procTask, user_procTaskPrio, user_procTaskQueue, user_procTaskQueueLen);
}
