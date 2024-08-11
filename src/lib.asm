; lib.asm - Core macros and functions

section .data
    digit_buffer times 20 db 0

section .text
    global print_string
    global print_int

; Function to print a null-terminated string
; Input: rdi - pointer to the string
print_string:
    push rax
    push rdi
    push rsi
    push rdx
    
    ; Find string length
    mov rsi, rdi
    xor rdx, rdx
    dec rdx
.count:
    inc rdx
    cmp byte [rsi + rdx], 0
    jne .count
    
    ; Print the string
    mov rax, 1  ; sys_write
    mov rsi, rdi
    mov rdi, 1  ; stdout
    syscall
    
    pop rdx
    pop rsi
    pop rdi
    pop rax
    ret

; Function to print an integer
; Input: rdi - integer to print
print_int:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi

    mov rax, rdi
    mov rcx, 0
    mov rbx, 10
    lea rsi, [digit_buffer + 19]
    mov byte [rsi], 0

.divide_loop:
    xor rdx, rdx
    div rbx
    add dl, '0'
    dec rsi
    mov [rsi], dl
    inc rcx
    test rax, rax
    jnz .divide_loop

    mov rdi, rsi
    call print_string

    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

; Add more core macros and functions as needed