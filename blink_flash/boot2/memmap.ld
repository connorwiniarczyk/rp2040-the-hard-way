MEMORY {
	SRAM(rx) : ORIGIN = 0X20041F00, LENGTH = 252
}

SECTIONS {
	. = ORIGIN(SRAM);
	.text : {
		*(.entry)
		*(.text)
	} > SRAM
}
