# define binaries to use for the linker and assembler
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
CC = arm-none-eabi-gcc

# define the cpu we are building for
CPU = -mcpu=cortex-m0

ASSEMBLER_ARGS = --warn --fatal-warnings $(CPU)
LINKER_ARGS = -nostdlib
COMPILER_ARGS = -nostdlib $(CPU) # TODO


all: build/boot2_crc.s

build/boot2.o: boot2.s
	@mkdir -p build
	$(AS) $(ASSEMBLER_ARGS) $< -o $@

build/boot2.elf: build/boot2.o memmap.ld
	@mkdir -p build
	$(LD) $(LINKER_ARGS) -T memmap.ld build/boot2.o -o $@

build/boot2.bin: build/boot2.elf
	arm-none-eabi-objcopy -O binary $< $@

build/boot2_crc.s: build/boot2.bin
	python3 pad_crc.py build/boot2.bin -o build/boot2_crc.s

inspect: build/boot2.elf
	arm-none-eabi-objdump -D $< | less

clean:
	@rm -rf build

