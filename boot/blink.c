#define RESET_CTRL 0x4000c000
#define RESET_CLEAR 0x4000f000

#define GPIO_17_CTRL 0x4001408c 
#define SIO_BASE 0xD0000000
#define SIO_OUTPUT_ENABLE (SIO_BASE + 0x24)
#define SIO_OUTPUT_XOR (SIO_BASE + 0x1C)
#define DELAY_CYCLES 0x00400000

void write_register(int dest, int value);
int read_register(int src);

int main (void) {
	write_register(RESET_CLEAR, 1 << 5);		
	while (read_register(RESET_CLEAR) != 0);
	
	write_register(GPIO_17_CTRL, 5);

	while (1) {
		write_register(SIO_OUTPUT_XOR, 1 << 17);
		for (int i=0;i<0x00300000; i++);
	}
	
}
