# 6502 arithmetic library

This library implements 32 bit signed integer operations for the 6502 microprocessor. It does not
use any ROM routines and is therefore independent of any operating environment. In other words: It
should run on any machine with a compatible microprocessor. This includes: All commodore 8 bit machines,
the Atari 8 bit machines, the Apple II, the BBC micro, the Oric, the Commander X16, heck it should even
run on the KIM-1 if it would have enough RAM. The following routines are provided:

- Addition
- Subtraction
- Comparisons: Equality, test for zero, greater or equal
- Multiplication
- Squaring
- Left and right shifting one bit (i.e. multiplication and division by 2)
- Copying (moving) 
- 8 by 8 bit unsigned multiplication with a 16 bit result

General division is **not** implemented. The assembled binary has as size of about 1250 bytes 512 of which
are part of a table which is used for 16 bit multiplication.

# Building and customizing

You will need the ACME macro assembler in order to build the library. You can can change the contents
of `zeropage.a` in order to use zero page addresses which are available for use on the target system. The 
current values in this file are tuned for the Commodore 64. The target address can be changed in the `main.a` 
file. Documentation for the routines is provided in the source code as comments.

You can use the included `makefile` to build the library. The makefile also offers the possibility to test
the correctness of the routines by calling `make test`. This target uses my [6502profiler](https://github.com/rmsk2/6502profiler)
testing tool. The tests are a conglomerate of assembly, json and Lua files and can be found in the `tests` directory.