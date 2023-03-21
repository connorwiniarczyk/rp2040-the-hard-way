.cpu cortex-m0
.thumb

_start:
	b main
	b .

.global write_register
write_register:
	str r1, [r0]	
	bx lr

.global read_register
read_register:
	ldr r0, [r0]
	bx lr
