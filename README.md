# 6502 arithmetic library

This library implements 32 bit signed integer operations for the 6502 microprocessor. Additionally routines
for signed fixed point multiplication and squaring can optionally be included. The following variants are
available

- 8 bit integer and 24 bit fractional part
- 16 bit integer and 16 bit fractional part
- 24 bit integer and 8 bit fractional part

It does not use any ROM routines and is therefore independent of any operating environment. In other words: 
It should run on any machine with a compatible microprocessor. This includes: All commodore 8 bit machines,
the Atari 8 bit machines, the Apple II, the BBC micro, the Oric, the Commander X16, heck it should even
run on the KIM-1. The following routines are provided:

- Addition
- Subtraction
- Comparisons: Equality, test for zero, greater or equal
- Multiplication
- Squaring
- Left and right shifting one bit (i.e. multiplication and division by 2)
- Copying (moving) 
- 8 by 8 bit unsigned multiplication with a 16 bit result

General division is **not** implemented. Apart from multiplication and squaring the routines do not care about
where a decimal point (or comma depending on where you live) is assumed to be and so the library also provides
the above operations for fixed point numbers in the variants mentioned above. 

The assembled binary has a size of about 1250 bytes in the default configuration (512 of which are part of a table 
which is used for 16 bit multiplication) but you can customize the library to be as short as about 720 bytes. See 
the following section about customizing what is included in the binary.

# Building and customizing

You will need the ACME macro assembler in order to build the library. You can can change the contents
of `zeropage.a` in order to use zero page addresses which are available for use on the target system. The 
current values in this file are tuned for the Commodore 64. The target address can be changed in the `main.a` 
file by modifying the `* = ....` pseudo opcode. Documentation for the routines is provided in the source code as 
comments.

The file `arith.a` can be customized to get rid of the multiplication table in order to save same space by not
defining the variable `FAST_MUL` in `zeropage.a`. Beware though that the performance hit for multiplication and 
squaring is significant (3-4 times slower). 

The fixed point multiplication and squaring routines can be enabled by defining one (or all) of the variables 
`FIXED8`, `FIXED16` or `FIXED24` in `main.a`.

You can use the included `makefile` to build the library. The makefile also offers the possibility to test
the correctness of the routines by calling `make test` or `make verbtest`. These target use my 
[6502profiler](https://github.com/rmsk2/6502profiler) testing tool. The tests are a conglomerate of assembly, json 
and Lua files and can be found in the `tests` directory.

# Fixed point arithmetic what's that?

In fixed point arithmetic we assume that in each 32 bit number there is a decimal point (or comma) at a fixed position.
In this library there are routines that assume this position to be after the first, second or third most significant byte. 
Let's make this a bit more concrete by assuming that the comma is after the most significant byte. In this case we have
one byte as an integer part and three bytes as a fractional part. The largest number that can be represented in this
format is 255 + 1/2 + 1/4 + 1/16 + 1/32 + ..... + 1/(2^24).

In memory this number is represented as 5 bytes. The first byte (i.e. the byte at the lowest address) is the sign byte where 1 
indicates a negative sign and 0 a positive sign. The sign byte is followed by the byte holding the eight least significant 
bits after the comma, followed by the next more significant bits after the comma and so on. The last byte contains the eight 
bits before the fixed point. I.e. the memory layout is as follows: 

```
sign byte | byte 0 fractional part | byte 1 fractional part | byte 2 fractional part | one byte integer part
```

examples:
 
 ```
+1.5  = 1 + 1/2       = $00, $00, $00, $80, $01
-2.25 = 2 + 1/4       = $01, $00, $00, $40, $02
+3.75 = 3 + 1/2 + 1/4 = $00, $00, $00, $C0, $03
-0.001953125 = 1/512  = $01, $00, $80, $00, $00
```

The interpretation of this memory layout has to be adapted accordingly for the case where the integer part is assumed to 
be two or three bytes. 

The maximum number that can be represented obviously depends of the number of bytes that make up the integer part and the 
lowest number as well as the achievable precision correspondingly depend on the number of bytes that are used for the fractional 
part. The following table should give a first impression what this means:

|Bits in integer part| Range of numbers | Smallest (absolute) number |
|-|-|-|
|8 | -256 < x < 256 | 0.00000006 = 1/(2^24) |
|16| -65536 < x < 65536 | 0.000015259 = 1/65536|
|24| -16777216 < x < 16777216 | 0.00390625 = 1/256 |