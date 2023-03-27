MEMORY {
	boot2(rx) : ORIGIN = 0x10000000, LENGTH = 256
	program(rx) : ORIGIN = 0x10000100, LENGTH = 0x1000
}

SECTIONS {
	.boot2 : { build/boot2.o (.boot2) } > boot2
	.program : { *(.text) } > program
}
