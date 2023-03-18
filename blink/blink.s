.cpu cortex-m0
.thumb

init:
	// write 32 to the reset clear register
	ldr r0, rst_clr
	mov r1, #32
	str r1,[r0]

// loop until rst_clr is equal to 0
check_reset_cleared:
	ldr r0, rst_base
	ldr r1, rst_clr
	cmp r1, #0
	beq check_reset_cleared

	// Assign GPIO 17 to SIO control
	ldr r0, gpio_17_ctrl_reg
	mov r1, #5
	str r1, [r0, #0]

	// set r1 to 1 << 17
	// write 1 << 17 to the SIO Output Enable register
	mov r1, #1
	lsl r1, r1, #17
	ldr r0, sio_base
	str r1, [r0, #0x24]

// loop forever
loop:
	// toggle the LED by writing 1 << 17 to the GPIO_OUT_XOR register, then
	// run the delay function
	str r1, [r0, #0x1C]
	ldr r3, delay_cycles
	bl delay

	b loop

// loads delay_cycles into a counter and subtracts 1 from it every cycle until
// it reaches 0
delay:
	sub r3, #1
	bne delay
	bx lr

// --------------------
// CONSTANT DEFINITIONS
// --------------------
// A bank of constant values used by our program. Mostly these are register
// addresses

.align
rst_base:
	.word 0x4000c000

rst_clr:
	.word 0x4000f000

gpio_17_ctrl_reg:
	.word 0x4001408c 

sio_base:
	.word 0xd0000000

// Number of cycles to delay for in the delay function
delay_cycles:
	.word 0x00400000
