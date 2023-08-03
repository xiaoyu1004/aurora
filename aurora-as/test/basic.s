# .text
# .global _start
# _start:

# set x10 to 0
xor     x10,    x10, x10
# x10 = x10 + 6
addi x10,   x10,   2
# set x11 to 0
xor x11,   x11,               x11
# x11 = x11 + 2
addi                x11,  x11,  3
# x10 = x10 + x11
add x10, x10, x11
addi x10, x10, -1
addi x10, x10, -3

# exit:
#     # Setup the parameters to exit the program and then call Linux to do it.
#     addi    a7, x0, 93  # Service command code 93 terminates
#     ecall               # Call linux to terminate the program
