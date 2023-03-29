MEMORY {
	FLASH (rx) : ORIGIN = 0X10000000, LENGTH = 2048k
}

SECTIONS {
	.boot2 : { *(.boot2) } > FLASH
}
