; test_test.asm - Test cases for the test module

extern assert_eq
extern assert_ne
extern assert_lt
extern assert_gt
extern print_module_name
extern print_string

section .data
    module_name db "test.asm", 0
    test_equal db "Equal values", 0
    test_not_equal db "Not equal values", 0
    test_less_than db "Less than", 0
    test_greater_than db "Greater than", 0
    success_msg db "All tests completed!", 0
    newline db 10, 0

section .text
    global _start

_start:
    ; Print module name
    mov rdi, module_name
    call print_module_name

    ; Test case 1: assert_eq with equal values
    mov rdi, 5
    mov rsi, 5
    mov rdx, test_equal
    call assert_eq

    ; Test case 2: assert_ne with unequal values
    mov rdi, 5
    mov rsi, 6
    mov rdx, test_not_equal
    call assert_ne

    ; Test case 3: assert_lt with less than values
    mov rdi, 4
    mov rsi, 5
    mov rdx, test_less_than
    call assert_lt

    ; Test case 4: assert_gt with greater than values
    mov rdi, 6
    mov rsi, 5
    mov rdx, test_greater_than
    call assert_gt

    ; Print completion message
    mov rdi, success_msg
    call print_string
    mov rdi, newline
    call print_string

    ; Exit the program
    mov rax, 60
    xor rdi, rdi
    syscall