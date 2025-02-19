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
﻿
//****************************************************************************************************************************
//Program name: "Arrays of floating point numbers".  This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, along with the variance of the numbers.
// Copyright (C) 2025 Anderson Pham.          *
//                                                                                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
//but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
//the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
//<https://www.gnu.org/licenses/>.                                                                                           *
//****************************************************************************************************************************
//****************************************************************************************************************************

//Author: Anderson Pham
//Author email: ahpham123@csu.fullerton.edu
//CWID: 884815002
//Class: 240-03 Section 03
//Program name: Arrays of Floating Point Numbers
//Programming languages: One module in C, six in x86, one in C++, and one in bash
//Date program began: 2025-Feb-16
//Date of last update: 2025-Feb-16
//Files in this program: main.c, manager.asm, input_array.asm, compute_mean.asm, isfloat.asm, output_array.c, compute_variance.cpp, r.sh.
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program: This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, along with the variance of the numbers.
//  
//This file
//  File name: main.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc  -m64 -Wall -no-pie -o main.o -std=c2x -c main.c
//  Link: g++ -m64 -no-pie -o arr.out manage.o input.o mean.o isfloat.o output.o main.o variance.o -std=c2x -Wall -z noexecstack -lm

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

//declaration for external function
extern "C" double manager();

int main(void)
{
 printf("Welcome to Arrays of Floating Point Numbers.\n");
 printf("Brought to you by Anderson Pham\n");
 
 //Begin program
 double count = 0;
 count = manager();
 
 //Main is supposed to recieve sum
 printf("\nMain has received %.10lf and will keep it for future use.\n",count);
 printf("Main will return 0 to the operating system. Bye.\n");

 return 0;
}
main.cpp
4 KB
