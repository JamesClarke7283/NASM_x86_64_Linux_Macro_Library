; test.asm - Enhanced unit testing framework for NASM x86_64 Linux

extern print_string
extern print_int

section .data
    module_name_msg db "Testing module: ", 0
    test_pass_msg db "  ✓ Test passed: ", 0
    test_fail_msg db "  ✗ Test failed: ", 0
    expected_msg db " - Expected: ", 0
    actual_msg db ", Actual: ", 0
    expected_less db " - Expected less than: ", 0
    expected_greater db " - Expected greater than: ", 0
    newline db 10, 0

section .text
    global run_tests
    global assert_eq
    global assert_ne
    global assert_lt
    global assert_gt
    global print_test_name
    global print_module_name

; Function to run tests
run_tests:
    ret

; Function to assert equality
; Input: 
;   rdi - First value (expected)
;   rsi - Second value (actual)
;   rdx - Pointer to test name
assert_eq:
    push rbp
    mov rbp, rsp
    
    cmp rdi, rsi
    je .pass
    
    ; Test failed
    push rsi
    push rdi
    push rdx
    call print_fail
    add rsp, 24
    jmp .end
    
.pass:
    push rdx
    call print_pass
    add rsp, 8
    
.end:
    mov rsp, rbp
    pop rbp
    ret

; Function to assert inequality
; Input: 
;   rdi - First value
;   rsi - Second value
;   rdx - Pointer to test name
assert_ne:
    push rbp
    mov rbp, rsp
    
    cmp rdi, rsi
    jne .pass
    
    ; Test failed
    push rsi
    push rdi
    push rdx
    call print_fail
    add rsp, 24
    jmp .end
    
.pass:
    push rdx
    call print_pass
    add rsp, 8
    
.end:
    mov rsp, rbp
    pop rbp
    ret

; Function to assert less than
; Input: 
;   rdi - First value
;   rsi - Second value
;   rdx - Pointer to test name
assert_lt:
    push rbp
    mov rbp, rsp
    
    cmp rdi, rsi
    jl .pass
    
    ; Test failed
    push rdi
    mov rdi, test_fail_msg
    call print_string
    pop rdi
    push rdi
    push rsi
    push rdx
    mov rdi, rdx
    call print_string
    mov rdi, expected_less
    call print_string
    pop rdx
    pop rsi
    pop rdi
    push rdi
    mov rdi, rsi
    call print_int
    mov rdi, actual_msg
    call print_string
    pop rdi
    call print_int
    jmp .end
    
.pass:
    push rdx
    call print_pass
    add rsp, 8
    
.end:
    mov rdi, newline
    call print_string
    mov rsp, rbp
    pop rbp
    ret

; Function to assert greater than
; Input: 
;   rdi - First value
;   rsi - Second value
;   rdx - Pointer to test name
assert_gt:
    push rbp
    mov rbp, rsp
    
    cmp rdi, rsi
    jg .pass
    
    ; Test failed
    push rdi
    mov rdi, test_fail_msg
    call print_string
    pop rdi
    push rdi
    push rsi
    push rdx
    mov rdi, rdx
    call print_string
    mov rdi, expected_greater
    call print_string
    pop rdx
    pop rsi
    pop rdi
    push rdi
    mov rdi, rsi
    call print_int
    mov rdi, actual_msg
    call print_string
    pop rdi
    call print_int
    jmp .end
    
.pass:
    push rdx
    call print_pass
    add rsp, 8
    
.end:
    mov rdi, newline
    call print_string
    mov rsp, rbp
    pop rbp
    ret

; Function to print test pass message
print_pass:
    push rbp
    mov rbp, rsp
    mov rdi, test_pass_msg
    call print_string
    mov rdi, [rbp+16]  ; Test name
    call print_string
    mov rdi, newline
    call print_string
    mov rsp, rbp
    pop rbp
    ret

; Function to print test fail message
print_fail:
    push rbp
    mov rbp, rsp
    mov rdi, test_fail_msg
    call print_string
    mov rdi, [rbp+24]  ; Test name
    call print_string
    mov rdi, expected_msg
    call print_string
    mov rdi, [rbp+16]  ; Expected value
    call print_int
    mov rdi, actual_msg
    call print_string
    mov rdi, [rbp+8]   ; Actual value
    call print_int
    mov rdi, newline
    call print_string
    mov rsp, rbp
    pop rbp
    ret

; Function to print test name
print_test_name:
    push rbp
    mov rbp, rsp
    call print_string
    mov rdi, newline
    call print_string
    mov rsp, rbp
    pop rbp
    ret

; Function to print module name
print_module_name:
    push rbp
    mov rbp, rsp
    mov rsi, rdi
    mov rdi, module_name_msg
    call print_string
    mov rdi, rsi
    call print_string
    mov rdi, newline
    call print_string
    mov rsp, rbp
    pop rbp
    ret