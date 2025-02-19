kito
kiiteo
memebun_uwutearsballs

LevelBubble — 1/30/25, 6:54 PM
oh so 25 is junk data
kito — 1/30/25, 6:54 PM
basically
you just want that space on the top of the stack
then you dereference rsp when calling movsd because you want what its pointing to and not the pointer
LevelBubble — 1/30/25, 6:55 PM
yeye
kito — 1/30/25, 6:55 PM
make sense ?
LevelBubble — 1/30/25, 6:55 PM
yea i get it
would there be a difference between doing movsd xmm10, [rsp] and movsd xmm10, [rsi]?
since they are both pointing to the same address
on line 163
kito — 1/30/25, 6:56 PM
rsi is for arguments, vs rsp is always pointing at the stack
*top of the stack
LevelBubble — 1/30/25, 6:57 PM
oh ok
would it still work but be bad practice or would it brick the program
kito — 1/30/25, 6:57 PM
doing mov rsi, rsp basically is just having rsp be the second parameter for the function when you call it
I would just avoid it :awkward:
LevelBubble — 1/30/25, 6:58 PM
oh oki
kito — 1/30/25, 6:58 PM
the value might not still be in rsi either
since youre using it just for that function call
LevelBubble — 1/30/25, 6:58 PM
ic, oki thx
LevelBubble — 1/31/25, 1:20 PM
I tried doing this and it worked, how would I print the value pointed to by xmm9 or xmm10 for debugging/future reference in my program?

i tried doing the following
    mov rax, 0
    mov rdi, [xmm10]
    call printf

but my bash terminal outputs
triangle.asm:165: error: invalid 64-bit effective address
, is this because the address isnt aligned or something?
kito — 1/31/25, 1:24 PM
you wanna move whatever floats you want to print to xmm0-7
rdi (first argument) should be a format string
like "%lf"
then you wanna move rax however many floats youre using in arguments
so like:
mov rax, 1
mov rdi, floatformat
movsd xmm0, xmm10
call printf
LevelBubble — 1/31/25, 1:28 PM
thank you sm, it works.

is there a reason why we store into xmm9/xmm10 instead of storing directly into xmm0?
ik some xmm registers are volatile but im not too clear on the techncial differences
kito — 1/31/25, 1:29 PM
xmm0-7 are volatile, meaning they dont save after function call
storing your values in non volatile registers like 8-10 will ensure they stay stored
for however long you need them
LevelBubble — 1/31/25, 1:30 PM
oh so xmm7 and up are for permanent storage and then using xmm0-7 for function calls ensures the data is being copied instead of manipulated directly?
kito — 1/31/25, 1:30 PM
8 and up
LevelBubble — 1/31/25, 1:30 PM
oh yeah mb
kito — 1/31/25, 1:30 PM
but it basically makes sure they dont disappear after function call
or get overridden
since some functions will return results in xmms
LevelBubble — 1/31/25, 1:32 PM
how come we use other registers instead of just passing xmm9 directly into functions, seems kind of convaluted for printing
is it a rule?
kito — 1/31/25, 1:33 PM
It just looks at xmm0 first and then in ascending order
like how rdi gets looked at as the first argument
LevelBubble — 1/31/25, 1:34 PM
oh ok
thx for the help :}
LevelBubble — 2/4/25, 12:10 PM
hey I was wondering if you could run my assignment on your computer to see if it runs ok?
kito — 2/4/25, 3:31 PM
yeah sure !
LevelBubble — 2/4/25, 3:41 PM
//****************************************************************************************************************************

//Author: Anderson Pham
//Author email: ahpham123@csu.fullerton.edu
//CWID: 884815002
//Class: 240-03 Section 03
Expand
geometry.c
2 KB
Attachment file type: code
triangle.asm
7.60 KB
#/bin/bash

#Program name "Triangle"
#Author: Anderson Pham
#Author Email: ahpham123@csu.fullerton.edu
#CWID: 884815002
Expand
r.sh
1 KB
thx
kito — 2/4/25, 7:23 PM
runs perfectly :)
LevelBubble — 2/4/25, 7:35 PM
sweet, thx
LevelBubble — Today at 11:39 AM
Attachment file type: code
input_array.asm
4.79 KB
Attachment file type: code
output_array.asm
2.22 KB
//****************************************************************************************************************************
//Program name: "Arrays of floating point numbers".  This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, along with the variance of the numbers.
// Copyright (C) 2025 Anderson Pham.          *
//                                                                                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
Expand
main.cpp
4 KB
#/bin/bash

#Program name "Arrays of Floating Point Numbers"
#Author: Anderson Pham
#Author Email: ahpham123@csu.fullerton.edu
#CWID: 884815002
Expand
r.sh
2 KB
﻿
#/bin/bash

#Program name "Arrays of Floating Point Numbers"
#Author: Anderson Pham
#Author Email: ahpham123@csu.fullerton.edu
#CWID: 884815002
#Class: 240-03 Section 03
#This file is the script file that accompanies the "Arrays of Floating Point Numbers" program.
#Prepare for execution in normal mode (not gdb mode).

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble the source input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the source file isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Compile the source file main.cpp"
g++  -m64 -Wall -no-pie -o main.o -std=c++20 -c main.cpp

echo "Assemble the source file manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble the source file output_array.asm"
nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm

echo "Compile the source file sort.c"
gcc  -m64 -Wall -no-pie -o sort.o -std=c2x -c sort.c

echo "Assemble the source file sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "Assemble the source file swap.asm"
nasm -f elf64 -l swap.lis -o swap.o swap.asm

echo "Link the object modules to create an executable file"
g++ -m64 -no-pie -o output.out manager.o main.o sort.o swap.o isfloat.o input_array.o output_array.o sum.o -z noexecstack -lm

echo "Execute the program"
chmod +x output.out
./output.out

echo "This bash script will now terminate."
r.sh
2 KB
