;declarations

global sum_array

extern printf

segment .data
;empty

segment .bss
;empty

segment .text

sum_array:

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


;initialize sum to 0.0
xorpd xmm0, xmm0 ; initialize xmm0 to zero
mov r14, rdi ; r14 = pointer to my_array
mov r15, rsi ; r15 = number of elements
xor r13, r13 ; r13 = loop counter (index)

sum_loop:
cmp r13, r15 ; Check if we processed all the elements
jge sum_done ; If so exit loop

;load my_array[r13] into xmm1
movq xmm1, [r14 + r13 * 8]  

;add to sum
addsd xmm0, xmm1  

;increment loop counter
inc r13
jmp sum_loop

sum_done:


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
pop rbp ;Restore rbp to the base of the activation record of the caller program
ret 
;End of the function sum ====================================================================