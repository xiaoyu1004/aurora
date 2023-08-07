`include "global_config.vh"
`include "cpu.vh"

module alu(
    // regfile
    input  wire [31:0]      rd_data_0,
    input  wire [31:0]      rd_data_1,
    // sext
    input   wire [31:0]     sext_out,

    input   wire [2:0]      inst_type,
    input   wire [3:0]      alu_op_type,
    output  reg  [31:0]     alu_out
);

    wire [31:0] alu_in0 = (inst_type == `INST_U) ? sext_out : rd_data_0;
    wire [31:0] alu_in1 = (inst_type == `INST_I || inst_type == `INST_S) ? sext_out : 
                                                    (inst_type == `INST_U) ? 32'd12 : 
                                                    rd_data_1;

    always @(*) begin
        case (alu_op_type) 
            `ALU_ADD: begin
                alu_out = alu_in0 + alu_in1;
            end
            `ALU_SUB: begin
                alu_out = alu_in0 + (~alu_in1) + 1;
            end
            `ALU_AND: begin
                alu_out = alu_in0 & alu_in1;
            end
            `ALU_OR: begin
                alu_out = alu_in0 | alu_in1;
            end
            `ALU_XOR: begin
                alu_out = alu_in0 ^ alu_in1;
            end
            `ALU_SLL: begin
                alu_out = alu_in0 << alu_in1;
            end
            `ALU_SRL: begin
                alu_out = alu_in0 >> alu_in1;
            end
            `ALU_SRA: begin
                alu_out = $signed(alu_in0) >>> alu_in1;
            end
            `ALU_EQ: begin
                alu_out = {{31{1'b0}}, {alu_in0 == alu_in1}};
            end
            `ALU_NE: begin
                alu_out = {{31{1'b0}}, {alu_in0 != alu_in1}};
            end
            `ALU_LT: begin
                alu_out = {{31{1'b0}}, {$signed(alu_in0) <= $signed(alu_in1)}};
            end
            `ALU_GE: begin
                alu_out = {{31{1'b0}}, {$signed(alu_in0) >= $signed(alu_in1)}};
            end
            default: begin
                alu_out = 32'b0;
            end
        endcase
    end
endmodule