# Makefile for NASM x86_64 Linux Macro Library

ASM=nasm
ASMFLAGS=-f elf64
LD=ld

SRC_DIR=src
TEST_DIR=tests
MODULES_DIR=$(SRC_DIR)/modules
BUILD_DIR=build

.PHONY: all test clean

all: test

test: $(BUILD_DIR)/test_lib $(BUILD_DIR)/test_test
	$(BUILD_DIR)/test_lib
	$(BUILD_DIR)/test_test

$(BUILD_DIR)/test_lib: $(BUILD_DIR)/test_lib.o $(BUILD_DIR)/lib.o $(BUILD_DIR)/test.o
	$(LD) -o $@ $^

$(BUILD_DIR)/test_test: $(BUILD_DIR)/test_test.o $(BUILD_DIR)/lib.o $(BUILD_DIR)/test.o
	$(LD) -o $@ $^

$(BUILD_DIR)/lib.o: $(SRC_DIR)/lib.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) -o $@ $<

$(BUILD_DIR)/test.o: $(MODULES_DIR)/test.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) -o $@ $<

$(BUILD_DIR)/%.o: $(TEST_DIR)/%.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) -o $@ $<

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)