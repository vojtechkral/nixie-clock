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
	uint32 pin_digit_clock;
	uint32 pin_digit_data;
	uint32 pin_digit_latch;
	volatile os_timer_t timer_digit;
} nixie_clock_t;


void shift_out_16(unsigned data, uint32 gpio_clock, uint32 gpio_data, uint32 gpio_latch)
{
	// Bits get shifted onti the register outputs in the following order:
	// LSB of the lower byte goes to Q7, 2nd register
	// MSB of the lower byte goes to Q0, 2nd register
	// LSB of the upper byte goes to Q7, 1st register
	// MSB of the upper byte goes to Q0, 1st register

	// TODO: delays? Nah...

	// os_printf("shift_out_16: 0x%x\n", data);

	gpio_output_set(0, gpio_latch, gpio_latch, 0);

	unsigned i;
	for (i = 0; i < 16; ++i, data >>= 1)
	{
		unsigned bit = data & 1;
		if (bit) gpio_output_set(gpio_data, gpio_clock, gpio_clock | gpio_data, 0);
		else gpio_output_set(0, gpio_clock | gpio_data, gpio_clock | gpio_data, 0);
		gpio_output_set(gpio_clock, 0, gpio_clock, 0);
		gpio_output_set(0, gpio_data, gpio_data, 0);
	}

	gpio_output_set(gpio_latch, 0, gpio_latch, 0);
}

static unsigned digit_tmp = 0;

void timer_digit_fn(void *arg)
{
	nixie_clock_t *clock = (nixie_clock_t*)arg;

	gpio_output_set(0, NM_BIT_LED, NM_BIT_LED, 0);

	// unsigned digit = clock->digits[clock->digit_current];
	unsigned digit = digit_tmp;
	digit_tmp = (digit_tmp + 1) % 10;
	unsigned data = 1 << clock->digit_current << 8;

	// BCD positions on 2nd shift register pins:
	// Q7 -> A
	// Q6 -> D
	// Q5 -> B
	// Q4 -> C
	// A is BCD LSB
	unsigned bcd = (digit & 1) | (digit & 8) >> 2 | (digit & 6) << 1;
	bcd = 1;

	data |= bcd;
	os_printf("digit/data: %u %u 0x%x\n", clock->digit_current, digit, data);
	clock->digit_current = (clock->digit_current + 1) % 4;

	shift_out_16(data, clock->pin_digit_clock, clock->pin_digit_data, clock->pin_digit_latch);

	os_delay_us(400 * 1000);
	gpio_output_set(NM_BIT_LED, 0, NM_BIT_LED, 0);
}

static void timer_kickoff(volatile os_timer_t *timer, os_timer_func_t *fn, unsigned delay, void *arg)
{
	os_timer_disarm(timer);
	os_timer_setfn(timer, fn, arg);
	os_timer_arm(timer, delay, 1);
	// os_timer_arm(timer, delay, 0);
}

static void nixie_clock_init(nixie_clock_t *clock)
{
	clock->digits[0] = 1;
	clock->digits[1] = 2;
	clock->digits[2] = 3;
	clock->digits[3] = 8;
	clock->digit_current = 0;
	os_timer_disarm(&clock->timer_digit);

	PIN_FUNC_SELECT(NM_NAME1, NM_FUNC1);  // clock - SHCP
	PIN_FUNC_SELECT(NM_NAME2, NM_FUNC2);  // latch - STCP
	PIN_FUNC_SELECT(NM_NAME3, NM_FUNC3);  // data  - DS
	clock->pin_digit_clock = NM_BIT1;
	clock->pin_digit_latch = NM_BIT2;
	clock->pin_digit_data = NM_BIT3;
	uint32 set_output = NM_BIT1 | NM_BIT2 | NM_BIT3;
	gpio_output_set(0, set_output, set_output, 0);
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
	os_printf("Hello, World!\n");

	PIN_FUNC_SELECT(NM_NAME_LED, NM_FUNC_LED);
	gpio_output_set(0, NM_BIT_LED, NM_BIT_LED, 0);

	nixie_clock_init(&nixie_clock);

	// timer_kickoff(&nixie_clock.timer_digit, timer_digit_fn, 40, &nixie_clock);
	timer_kickoff(&nixie_clock.timer_digit, timer_digit_fn, 1000, &nixie_clock);

	system_os_task(user_procTask, user_procTaskPrio, user_procTaskQueue, user_procTaskQueueLen);
}
