# Create executable

nasm -f elf32 -o HelloWorld.o HelloWorld.asm

ld -o HelloWorld HelloWorld.o
