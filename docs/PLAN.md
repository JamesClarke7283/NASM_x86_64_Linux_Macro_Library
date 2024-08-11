# NASM x86_64 Linux Macro Library Plan
The following is a plan for the library, on how to make it and what to make.

## Project structure
```
├── docs
│   ├── LICENSE.md
│   └── PLAN.md
├── LICENSE
├── Makefile - `Core commands to test the library`
├── README.md
├── src
│   ├── lib.asm - `Core macros that most other modules depend on`
│   └── modules
│       └── test.asm - `A small unit testing framework`
└── tests
    ├── test_lib.asm - Test cases for lib.asm (does not use test macros)
    └── test_test.asm - Test cases for test.asm (does not use test macros)
```

## Extra

### Logging
We will log all activity using the `log` package defined in `src/log`, this will let us trace what the program is doing and from what module its being done(this is a more advanced feature)

### Testing

We will write test cases for all code(apart from core and unit test code itself of course) using the `test` package defined in `src/test`. Tests for the `test` package will be written manually of course and have a more minimal output.

## Plan of development
This is the plan for developing the application.

### Phase 1: Setting the Foundations
The first module we make is the `test` module, which is a tiny unit testing framework that has `asserts` to make it easier for us to test other modules, tests for this module will be written manually(of course).

Any needed macros we need to invent to make this module possible, will go in the `lib.asm`

Please write a `Makefile` to make the `make test [default:all or a specific module]` work properly.