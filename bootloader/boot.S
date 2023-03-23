.cpu cortex-m0
.thumb

.section .text
_stage2_boot:
	push {lr}

	// Set pad configuration
	// SCLK 8mA drive, no slew limiting
	// SDx disable input Schmitt to reduce delay

	#define PADS_QSPI_BASE_ADDR 0x40020000
	ldr r3, =PADS_QSPI_BASE_ADDR

	// this value sets drive strength to 8mA and slew control to fast
	#define GPIO_QSPI_SCLK_VAL 33
	movs r0, #33
	str r0, [r3, #0x04]

	// read the value of the first data pin register and disable schmitt triggering
	// by clearing the second bin
	ldr r0, [r3, #0x08]
	movs r1, #0x02
	// bics r0, r1 // commented out because thumb instructions don't support bics, need to rewrite as an and

	// store the new value to the each data pin's register
	str r0, [r3, #0x08]
	str r0, [r3, #0x0c]
	str r0, [r3, #0x10]
	str r0, [r3, #0x14]

	#define XIP_SSI_BASE_ADDR 0x18000000
	ldr r3, =XIP_SSI_BASE_ADDR

	// dissable SSI before we start configuring it
	movs r1, #0
	str r1, [r3, #0x08]

	// set baud rate
	#define CLK_DIV 4
	ldr r1, =CLK_DIV
	str r1, [r3, #0x14]

	movs r1, #1
	movs r2, #0xf0 // value too big to use immediate
	str r1, [r3, r2]

program_sregs:
	#define SSI_CTRL0_VAL ((0x07 << 16) | (0x03 << 8))
	ldr r1, =SSI_CTRL0_VAL
	str r1, [r3, #0x00]

	// Enable SSI and select slave 0
	movs r1, #1
	str r1, [r3, #0x08]

	// check whether SR needs updating
	#define CMD_READ_STATUS2 0x35
	ldr r0, =CMD_READ_STATUS2

read_flash_sreg:
	push {r1, lr}

	str r0, [r3, #0x60]
	
	
wait_ssi_ready:
	push {r0, r1, lr}	
	
1:
	// read the status register into r1
	ldr r1, [r3, #0x28]
	movs r0, #(0x01 << 2) // the second bit of the status register indicates if the transmit buffer is empty
	tst r1, r0
	beq 1b

	movs r0, #(0x01 << 0)
	tst r1, r0
	bne 1b

	pop {r0, r1, pc}


