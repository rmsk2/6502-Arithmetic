# On MacOS use make MAC=1
# On Linux simply use make

all: arith.bin

ifdef MAC
ACME=/Users/martin/data/acme/acme
WORKDIR=.
else
ACME=acme
WORKDIR=.
endif

clean:
	rm $(WORKDIR)/arith.bin
	rm $(WORKDIR)/arith.txt
	rm $(WORKDIR)/tests/bin/*

arith.bin: main.a arith.a zeropage.a
	$(ACME) -l $(WORKDIR)/arith.txt -I $(WORKDIR)/ $(WORKDIR)/main.a

test:
	6502profiler verifyall -c $(WORKDIR)/config.json
