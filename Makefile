AS=uasm
ASFLAGS=-q -10 -elf64
LDFLAGS=-e main
BINDIR=bin
bin=fib hello printint
APPS := $(addprefix ./$(BINDIR)/,$(bin))

all: $(APPS) $(BINDIR)

$(BINDIR):
	mkdir -p $(BINDIR)

%.o: %.asm
	$(AS) $(ASFLAGS) $<

$(BINDIR)/fib: fib.o exit.o io.o
	ld $(LDFLAGS) -o $@ $^

$(BINDIR)/hello: hello.o io.o exit.o
	ld $(LDFLAGS) -o $@ $^

$(BINDIR)/printint: printint.o io.o exit.o
	ld $(LDFLAGS) -o $@ $^

.PHONY: clean strip
strip: all
	strip $(APPS)

clean:
	$(RM) *.o
	$(RM) -r $(BINDIR)
