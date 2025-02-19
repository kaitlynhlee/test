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
;  This program takes floating point number inputs from the user and puts them in an array. The array
;  values are then printed, along with the variance of the numbers.
;
;This file:
;  File name: output_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l output_array.lis -o output_array.o sirt.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l output_array.lis -o output_array.o output_array.asm
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations
extern printf

global output_array

segment .data
floatprintformat db "%1.2f", 10, 0

segment .bss
align 64
memory resb 832  

segment .text
output_array:

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

mov r13, 0
mov r15, 0  
mov r14, rdi     ;Array
mov r13, rsi     ;Array size

output_loop:
;End if counter is greater than or equal to array size
cmp r15, r13
je output_finished

mov rax, 1
movsd xmm0, [r14 + r15 * 8]
mov rdi, floatprintformat
call printf

inc r15
jmp output_loop:


output_finished:
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
