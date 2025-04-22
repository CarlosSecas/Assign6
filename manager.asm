;declarations
global manager

extern input_array
extern cvtt2n
extern read_clock
extern sum_array
extern printf
extern scanf


segment .data

present_time_msg db "The present time on the clock is %llu tics", 10,0
prompt_floats_msg db 10, "Enter float numbers positive or negative seperated by ws. Terminate with contrl+d", 10,0
sum_of_floats db 10, "The sum of these numbers is %.4f", 10,0
total_time db 10, "The total time to perform the additions in the ALU was %llu tics.", 10,0
average_tics db 10, "That is an average of %.1f tics per each addition.", 10,0
tics_to_ns db 10, "That number of tics equals %.1f ns." ,10,0

segment .bss

my_array resq 20 
sum_result resq 1
nano_result resq 1


segment .text

manager:

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


call read_clock
mov rsi, rax
mov rdi, present_time_msg
xor rax, rax ;clearing rax
call printf

mov rax, 0
mov rdi, prompt_floats_msg
call printf

;call input array
mov rdi, my_array
mov rsi, 20
call input_array

mov r13, rax ;Storing the number of inputs from rax into r13 for future operations. 

;Later subtract this from the end to compuite how long the summing took
call read_clock
mov r14, rax         ; r14 = start tics

; --- Call sum_array ---
mov rdi, my_array     ; pointer to array
mov rsi, r13          ; number of floats
call sum_array        ; result in xmm0

movq [sum_result], xmm0

mov rdi, sum_of_floats   
movsd xmm0, [sum_result]
mov rax, 1
call printf

call read_clock
mov r15, rax ; store current end time in r15
sub r15, r14 ; subtract endtime from starting time
mov r12, r15 ; preserve total tics in r12 for later calculations

; --- Print the total tics ---
mov rdi, total_time
mov rsi, r15
xor rax, rax
call printf

; === Calculate average tics per addition ===
cvtsi2sd xmm9, r12      ; xmm9 = total tics
cvtsi2sd xmm8, r13      ; xmm8 = number of inputs
divsd xmm9, xmm8        ; xmm9 = average = total_tics / count      

;Print Average tics after summing
mov rdi, average_tics   
movapd xmm0, xmm9
mov rax, 1
call printf

; --- Print the total tics ---
;mov rdi, total_time
;mov rsi, r15
;xor rax, rax
;call printf

;Convert to nanoseconds
cvtsi2sd xmm0, r12
call cvtt2n

movq [nano_result], xmm0  ; store nanoseconds to memory

mov rdi, tics_to_ns
movsd xmm0, [nano_result]
mov rax, 1
call printf

movsd xmm0, [nano_result]

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