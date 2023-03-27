
# define binaries to use for the linker and assembler
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
CC = arm-none-eabi-gcc

# define the cpu we are building for
CPU = -mcpu=cortex-m0

ASSEMBLER_ARGS = --warn --fatal-warnings $(CPU)
LINKER_ARGS = -nostdlib
COMPILER_ARGS = -nostdlib $(CPU) # TODO


# all: build/blink.elf

boot2.bin:
	$(AS) $(ASSEMBLER_ARGS) boot2_w25q080.S -o boot2.bin

# build/start.o: start.s
# 	@mkdir -p build
# 	$(AS) $(ASSEMBLER_ARGS) $< -o $@

# build/blink.o: blink.c
# 	@mkdir -p build
# 	$(CC) $(COMPILER_ARGS) -c $< -o $@

# build/blink.elf: build/start.o build/blink.o memmap.ld
# 	@mkdir -p build
# 	$(LD) $(LINKER_ARGS) -T memmap.ld build/start.o build/blink.o -o $@

# flash: build/blink.elf
# 	sudo openocd

clean:
	@rm -rf build
