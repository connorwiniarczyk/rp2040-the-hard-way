.cpu cortex-m0
.thumb

	ldr r0, rst_clr
	mov r1, #32
	str r1,[r0]

rst:
	ldr r0, rst_base
	ldr r1, rst_clr
	cmp r1, #0
	beq rst

	ldr r0, ctrl
	mov r1, #5
	str r1, [r0, #0]

	// set r1 to 1 << 17
	mov r1, #1
	lsl r1, r1, #17
	
	ldr r0, sio_base
	str r1, [r0, #0x24]

loop:
	str r1, [r0, #0x14]
	ldr r3, delay_cycles
	bl delay

	str r1, [r0, #0x18]
	ldr r3, delay_cycles
	bl delay

	b loop


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

ctrl:
	.word 0x4001408c 

sio_base:
	.word 0xd0000000

// Number of cycles to delay for in the delay function
delay_cycles:
	.word 0x00400000
