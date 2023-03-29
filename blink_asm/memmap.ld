MEMORY {
	SRAM(rx) : ORIGIN = 0x10000000, LENGTH = 256
}

SECTIONS {
	. = ORIGIN(SRAM);
	.text : {
		*(.entry)
		*(.text)
	} > SRAM
}
