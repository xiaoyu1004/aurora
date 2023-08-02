CWD=/home/yuhongzhang/workspace/aurora/

/opt/riscv64-gnu-toolchain/bin/riscv64-unknown-elf-as -o ${CWD}/build/hello.o ${CWD}/aurora-as/test/hello-world.s
/opt/riscv64-gnu-toolchain/bin/riscv64-unknown-elf-ld -o ${CWD}/build/hello ${CWD}/build/hello.o
/home/yuhongzhang/qemu-5.2.0/build/qemu-riscv64 ${CWD}/build/hello

# /opt/riscv64-gnu-toolchain/bin/riscv64-unknown-elf-gcc -o hello hello.s
# /home/yuhongzhang/qemu-5.2.0/build/qemu-riscv64 hello