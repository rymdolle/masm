bin=fib hello_world printint

all: $(bin)

fib.o: fib.asm
	uasm -q -10 -elf64 $<

printint.o: printint.asm
	uasm -q -10 -elf64 $<

exit.o: exit.asm
	uasm -q -10 -elf64 $<

io.o: io.asm
	uasm -q -10 -elf64 $<

hello_world.o: hello_world.asm
	uasm -q -10 -elf64 $<

fib: fib.o exit.o io.o
	ld -e main -o $@ $^

hello_world: hello_world.o io.o exit.o
	ld -e main -o $@ $^

printint: printint.o io.o exit.o
	ld -e main -o $@ $^

.PHONY: clean
clean:
	rm -f $(bin) *.o
