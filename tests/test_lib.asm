; test_lib.asm - Test cases for lib.asm

extern print_string
extern print_int
extern assert_eq
extern assert_ne
extern assert_lt
extern assert_gt
extern print_module_name

section .data
    module_name db "lib.asm", 0
    test_string db "Hello, World!", 0
    test_print_string db "print_string function", 0
    test_print_int db "print_int function", 0
    test_assert_eq db "assert_eq function", 0
    test_assert_ne db "assert_ne function", 0
    test_assert_lt db "assert_lt function", 0
    test_assert_gt db "assert_gt function", 0
    success_msg db "All tests passed!", 0
    newline db 10, 0

section .text
    global _start

_start:
    ; Print module name
    mov rdi, module_name
    call print_module_name

    ; Test case: print_string function
    mov rdi, test_string
    call print_string
    mov rdi, newline
    call print_string

    ; Test case: print_int function
    mov rdi, 42
    call print_int
    mov rdi, newline
    call print_string

    ; Test case: assert_eq
    mov rdi, 42
    mov rsi, 42
    mov rdx, test_assert_eq
    call assert_eq

    ; Test case: assert_ne
    mov rdi, 42
    mov rsi, 43
    mov rdx, test_assert_ne
    call assert_ne

    ; Test case: assert_lt
    mov rdi, 41
    mov rsi, 42
    mov rdx, test_assert_lt
    call assert_lt

    ; Test case: assert_gt
    mov rdi, 43
    mov rsi, 42
    mov rdx, test_assert_gt
    call assert_gt

    ; Print success message
    mov rdi, success_msg
    call print_string
    mov rdi, newline
    call print_string

    ; Exit the program
    mov rax, 60
    xor rdi, rdi
    syscall