make: delete main.o
	gcc -m32 main.o -o main

main.o:
	nasm -g -f elf32 main.asm -o main.o

delete:
	rm -rf main.o