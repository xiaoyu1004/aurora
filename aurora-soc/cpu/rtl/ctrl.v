`include "global_config.vh"
`include "cpu.vh"

module ctrl(
    input  [31:0]           inst,
    // pc
    output   wire           flush_pc,
    output   wire           if_br_inst,
    output   wire           if_jal_inst,
    // regfile
    output   wire           rf_we,
    // sext
    output   reg [2:0]      inst_type,
    output   wire           if_shift_imm_inst,
    // alu
    output   reg [3:0]      alu_op_type,
    // dram
    output   wire           dram_wr_en,
    // writeback
    output   wire           if_load_inst
);

    wire [6:0]  opcode = inst[6:0];
    wire [2:0]  funct3 = inst[14:12];
    wire [6:0]  funct7 = inst[31:25];

    // R
    wire inst_add = (opcode == 7'b0110011 && funct3 == 3'b000 && funct7 == 7'b0000000);
    wire inst_sub = (opcode == 7'b0110011 && funct3 == 3'b000 && funct7 == 7'b0100000);
    wire inst_and = (opcode == 7'b0110011 && funct3 == 3'b111 && funct7 == 7'b0000000);
    wire inst_or  = (opcode == 7'b0110011 && funct3 == 3'b110 && funct7 == 7'b0000000);
    wire inst_xor = (opcode == 7'b0110011 && funct3 == 3'b100 && funct7 == 7'b0000000);
    wire inst_sll = (opcode == 7'b0110011 && funct3 == 3'b001 && funct7 == 7'b0000000);
    wire inst_srl = (opcode == 7'b0110011 && funct3 == 3'b101 && funct7 == 7'b0000000);
    wire inst_sra = (opcode == 7'b0110011 && funct3 == 3'b101 && funct7 == 7'b0100000);

    // I
    wire inst_addi = (opcode == 7'b0010011 && funct3 == 3'b000);
    wire inst_andi = (opcode == 7'b0010011 && funct3 == 3'b111);
    wire inst_ori  = (opcode == 7'b0010011 && funct3 == 3'b110);
    wire inst_xori = (opcode == 7'b0010011 && funct3 == 3'b100);
    wire inst_slli = (opcode == 7'b0010011 && funct3 == 3'b001 && funct7 == 7'b0000000);
    wire inst_srli = (opcode == 7'b0010011 && funct3 == 3'b101 && funct7 == 7'b0000000);
    wire inst_srai = (opcode == 7'b0010011 && funct3 == 3'b101 && funct7 == 7'b0100000);
    
    wire inst_lw   = (opcode == 7'b0000011 && funct3 == 3'b010);
    wire inst_jalr = (opcode == 7'b1100111 && funct3 == 3'b000);

    // S
    wire inst_sw   = (opcode == 7'b0100011 && funct3 == 3'b010);

    // B
    wire inst_beq  = (opcode == 7'b1100011 && funct3 == 3'b000);
    wire inst_bne  = (opcode == 7'b1100011 && funct3 == 3'b001);
    wire inst_blt  = (opcode == 7'b1100011 && funct3 == 3'b100);
    wire inst_bge  = (opcode == 7'b1100011 && funct3 == 3'b101);

    // U
    wire inst_lui  = (opcode == 7'b0110111);
    wire inst_jal  = (opcode == 7'b1101111);

    // flush_pc
    assign flush_pc = inst_jalr;

    // if_br_inst
    assign if_br_inst = (inst_type == `INST_B);

    // if_jal_inst
    assign if_jal_inst = inst_jal;

    // rf_we
    assign rf_we = (inst_type != `INST_S) & (inst_type != `INST_B);

    // inst_type
    always @(*) begin
        if (opcode == 7'b0110011) begin
            inst_type       = `INST_R;
        end else if (opcode == 7'b0010011 || flush_pc || if_load_inst) begin
            inst_type       = `INST_I;
        end else if (opcode == 7'b0100011) begin
            inst_type       = `INST_S;
        end else if (opcode == 7'b1100011) begin
            inst_type       = `INST_B;
        end else if (opcode == 7'b0110111) begin
            inst_type       = `INST_U;
        end else if (opcode == 7'b1101111) begin
            inst_type       = `INST_J;
        end else begin
            inst_type       = `INST_R;
        end
    end

    // if_shift_imm_inst
    assign if_shift_imm_inst = inst_slli | inst_srli | inst_srai;

    // alu_op_type
    always @(*) begin
        if (inst_add || inst_addi || inst_lw || inst_jalr || inst_sw) begin
            alu_op_type     = `ALU_ADD;
        end else if (inst_sub) begin
            alu_op_type     = `ALU_SUB;
        end else if (inst_and | inst_andi) begin
            alu_op_type     = `ALU_AND;
        end else if (inst_or | inst_ori) begin
            alu_op_type     = `ALU_OR;
        end else if (inst_xor | inst_xori) begin
            alu_op_type     = `ALU_XOR;
        end else if (inst_sll | inst_slli | inst_lui) begin
            alu_op_type     = `ALU_SLL;
        end else if (inst_srl | inst_srli) begin
            alu_op_type     = `ALU_SRL;
        end else if (inst_sra | inst_srai) begin
            alu_op_type     = `ALU_SRA;
        end else if (inst_beq) begin
            alu_op_type     = `ALU_EQ;
        end else if (inst_bne) begin
            alu_op_type     = `ALU_NE;
        end else if (inst_blt) begin
            alu_op_type     = `ALU_LT;
        end else if (inst_bge) begin
            alu_op_type     = `ALU_GE;
        end else begin
            alu_op_type     = `ALU_ADD;
        end
    end

    // dram_wr_en
    assign dram_wr_en = inst_sw;

    // if_load_inst
    assign if_load_inst = inst_lw;

endmodule