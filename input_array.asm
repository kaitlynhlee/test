;****************************************************************************************************************************
;Program name: "Arrays of floating point numbers".  This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, along with the sum, mean, and the array after sorting
; Copyright (C) 2025 Anderson Pham
;                                                                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Anderson Pham
;  Author email: ahpham123@csu.fullerton.edu
;  CWID: 884815002
;  Class: 240-03 Section 03
;
;Program information
;  Program name: Arrays of Floating Point Numbers
;  Programming languages: One module in C, six in x86, one in C++, and one in bash
;  Date program began: 2025-Feb-16
;  Date of last update: 2025-Feb-16
;  Files in this program: main.cpp, manager.asm, input_array.asm, output_array.asm, isfloat.asm, sum.asm, swap.asm, r.sh
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program takes floating point number inputs from the user and puts them in an array.
;
;This file:
;  File name: input_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l input.lis -o input.o input_array.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l input.lis -o input.o input_array.asm
;  Prototype of this function: extern double input_array();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations
extern printf
extern scanf
extern atof
extern isfloat

global input_array


segment .data
stringformat db "%s", 0
floatfalse db "The last input was invalid and not entered into the array", 10, 0
full_message db "The array has been filled.", 10, 0

segment .bss
  
segment .text
input_array:

;backup GPRs
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

;rdi contains array, rsi contains max size of 12

;Block that designates r15 as a counter to ensure array does not surpass max size
mov r15, 0

;Block that stores passed data to nonvolatile registers to ensure data integrity
mov r14, rdi ;Array
mov r13, rsi ;Size

;Ensures user does not input floats past max size
check_capacity:
cmp r15, r13
jl is_less
jmp is_full

;Block that reserves space on stack and then takes in user input for array insertion later
is_less:
push qword 0
push qword 0
mov rax, 0
mov rdi, stringformat
mov rsi, rsp
call scanf

;check whether user has input control+d in order to end the function/stop inputting values into function
cmp eax, -1
je control_d

;Block that checks if user input is a float
mov rdi, rsp
call isfloat
cmp rax, 0
je  nfloat

;Block that converts user input from string to float
mov rax, 0
mov rdi, rsp
call atof
movsd xmm15, xmm0
pop r9
pop r9

;Block that stores newly converted float into array and checks size
lea [r14+r15*8], xmm15
inc r15
jmp check_capacity

control_d:
    ;pop values off stack to avoid segmentation fault before going to function end
pop r9
pop r9  ;try add rsp, 8
jmp exit

;Block that informs user of full array and jumps to function end
is_full:
mov rax, 0
mov rdi, full_message
call printf
jmp exit

;Block that informs user to try again
nfloat:
mov rax, 0
mov rdi, floatfalse
call printf
pop r9
pop r9
jmp is_less

;store the length of the array/float counter into rax to be sent back to manager
exit:
mov rax, r14

;Restore the GPRs
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret
