.cpu cortex-m0
.thumb

.macro set_base a
	ldr r3, =(\a)
.endm

// Writes a 32 bit value to the address at base + offset, where base is stored in r3
.macro write value offset
	ldr r0, =(\value)
	mov r1, #\offset
	str r0, [r3, r1] 
.endm

// Same as write, but for values which are small enough for a move immediate instruction,
// slightly smaller and quicker
.macro write_imm value offset
	mov r0, #\value
	mov r1, #\offset
	str r0, [r3, r1] 
.endm

.section .text
_stage2_boot:
	// clear the IO_BANK0 bit of the reset register
	set_base 0x4000f000
	write_imm (1 << 5), 0

// loop until rst_clr is equal to 0
reset_clear_loop:
	cmp r3, #0
	beq reset_clear_loop

gpio_init:
	// Configure GPIO 17 and 25 for control by the SIO subsystem (5)
	set_base 0x40014000
	write_imm 5, 0xCC
	write_imm 5, 0x88

	// enable the leds
	set_base 0xD0000000
	write (1 << 17) | (1 << 25), 0x24

loop:
	// toggle the leds
	write (1 << 17) | (1 << 25), 0x1C

	ldr r4, =(0x000F0000)
	bl delay
	b loop

// loads delay_cycles into a counter and subtracts 1 from it every cycle until
// it reaches 0
delay:
	sub r4, #1
	bne delay
	bx lr
