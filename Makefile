all: fib hello_world

fib.o: fib.asm
	uasm -q -10 -elf64 $<

exit.o: exit.asm
	uasm -q -10 -elf64 $<

io.o: io.asm
	uasm -q -10 -elf64 $<

hello_world.o: hello_world.asm
	uasm -q -10 -elf64 $<

fib: fib.o exit.o
	ld -e main -o $@ $^

hello_world: hello_world.o io.o exit.o
	ld -e main -o $@ $^

.PHONY: clean
clean:
	rm -f fib *.o
