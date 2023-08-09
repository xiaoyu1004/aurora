# .text
# .global _start
# _start:
xor x10, x10, x10
addi x10, x10, 6

xor x11, x11, x11
addi x11, x11, 2

add x10, x10, x11

# exit:
#     # Setup the parameters to exit the program and then call Linux to do it.
#     addi    a7, x0, 93  # Service command code 93 terminates
#     ecall               # Call linux to terminate the program
