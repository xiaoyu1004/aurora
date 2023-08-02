.text
.global _start
_start:
    xor a0, a0, a0
    addi a0, a0, 6

    xor a1, a1, a1
    addi a1, a1, 2

    add a0, a0, a1

exit:
    # Setup the parameters to exit the program and then call Linux to do it.
    addi    a7, x0, 93  # Service command code 93 terminates
    ecall               # Call linux to terminate the program
