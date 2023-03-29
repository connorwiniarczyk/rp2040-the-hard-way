
# define binaries to use for the linker and assembler
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
CC = arm-none-eabi-gcc

# define the cpu we are building for
CPU = -mcpu=cortex-m0

ASSEMBLER_ARGS = --warn --fatal-warnings $(CPU)
LINKER_ARGS = -nostdlib
COMPILER_ARGS = -nostdlib $(CPU) # TODO


all: clean build/main.elf

boot2/build/boot2_crc.s:
	@make -C boot2 build/boot2_crc.s

build/boot2.o: boot2/build/boot2_crc.s
	@mkdir -p build
	$(AS) $(ASSEMBLER_ARGS) $< -o $@

build/main.elf: build/boot2.o memmap.ld
	@mkdir -p build
	$(LD) $(LINKER_ARGS) -T memmap.ld build/boot2.o -o $@

flash: build/main.elf
	sudo openocd

inspect: build/main.elf
	arm-none-eabi-objdump -D $< | less

clean:
	@rm -rf build
	@make -C boot2 clean
