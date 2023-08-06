`ifndef CPU_VH
`define CPU_VH

// pc
`define RESET_EDGE_ 1'b0
`DEFINE RESET_PC    32'b0

// irom
`define ROM_DEPTH   2048

// sext
`define INST_R       5'b000
`define INST_I       5'b001
`define INST_S       5'b010
`define INST_B       5'b011
`define INST_U       5'b100
`define INST_J       5'b101

// alu
// // inst
// `define INST_ADD    6'000000
// `define INST_SUB    6'000001
// `define INST_AND    6'000010
// `define INST_OR     6'000011
// `define INST_XOR    6'000100
// `define INST_SLL    6'000101
// `define INST_SRL    6'000110
// `define INST_SRA    6'000111

// `define INST_ADDI   6'001000
// `define INST_ANDI   6'001001
// `define INST_ORI    6'001010
// `define INST_XORI   6'001011
// `define INST_SLLI   6'001100
// `define INST_SRLI   6'001101
// `define INST_SRAI   6'001110
// `define INST_LW     6'001111
// `define INST_JALR   6'010000

// `define INST_SW     6'010001

// `define INST_BEQ    6'010010
// `define INST_BNE    6'010011
// `define INST_BLT    6'010100
// `define INST_BGE    6'010101

// `define INST_LUI    6'010110

// `define INST_JAL    6'010111

// op_type
`define ALU_ADD     4'b0000
`define ALU_SUB     4'b0001
`define ALU_AND     4'b0010
`define ALU_OR      4'b0011
`define ALU_XOR     4'b0100
`define ALU_SLL     4'b0101
`define ALU_SRL     4'b0110
`define ALU_SRA     4'b0111
`define ALU_EQ      4'b1000
`define ALU_NE      4'b1001
`define ALU_LT      4'b1010
`define ALU_GE      4'b1011

// dram
`define RAM_DEPTH   2048

`endif