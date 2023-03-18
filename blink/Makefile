
# define binaries to use for the linker and assembler
LD = arm-none-eabi-ld
AS = arm-none-eabi-as

# define the cpu we are building for
CPU = -mcpu=cortex-m0

ASSEMBLER_ARGS = --warn --fatal-warnings $(CPU)
LINKER_ARGS = -nostdlib

all: build/blink.elf

build/blink.o: blink.s
	@mkdir -p build
	$(AS) $(ASSEMBLER_ARGS) $< -o $@

build/blink.elf: build/blink.o memmap.ld
	@mkdir -p build
	$(LD) $(LINKER_ARGS) -T memmap.ld $< -o $@

flash: build/blink.elf
	sudo openocd
