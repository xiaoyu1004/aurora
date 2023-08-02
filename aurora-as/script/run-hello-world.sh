CWD=/home/yuhongzhang/workspace/aurora/

# /opt/riscv64-gnu-toolchain/bin/riscv64-unknown-elf-as -o ${CWD}/build/hello.o ${CWD}/aurora-as/test/hello-world.s
# /opt/riscv64-gnu-toolchain/bin/riscv64-unknown-elf-ld -o ${CWD}/build/hello ${CWD}/build/hello.o
# /home/yuhongzhang/qemu-5.2.0/build/qemu-riscv64 ${CWD}/build/hello

# /opt/riscv-gnu-toolchain/bin/riscv32-unknown-elf-gcc -o ${CWD}/build/add ${CWD}/aurora-as/test/add.s
# /home/yuhongzhang/qemu-5.2.0/build/qemu-riscv32 ${CWD}/build/add

/opt/riscv-gnu-toolchain/bin/riscv32-unknown-elf-as -o ${CWD}/build/add.o ${CWD}/aurora-as/test/add.s
/opt/riscv-gnu-toolchain/bin/riscv32-unknown-elf-ld -o ${CWD}/build/add ${CWD}/build/add.o
/home/yuhongzhang/qemu-5.2.0/build/qemu-riscv32 ${CWD}/build/add
echo $?
/opt/riscv-gnu-toolchain/bin/riscv32-unknown-elf-objcopy -O binary ${CWD}/build/add ${CWD}/build/add.bin