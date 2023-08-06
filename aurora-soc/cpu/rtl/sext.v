`include "global_config.vh"
`include "cpu.vh"

module sext(
    input   wire [24:0]     imm_in,
    input   wire [4:0]      inst_type,
    input   wire            if_shift_imm_inst,
    output  reg  [31:0]     sext_out
);
    always @(*) begin
        if (inst_type == `INST_I && if_shift_imm_inst == 1'b0) begin
            sext_out     = {20{imm_in[24]}, imm_in[24, 13]};
        end else if (inst_type == `INST_I && if_shift_imm_inst == 1'b1) begin
            sext_out     = {27{imm_in[17]}, imm_in[17, 13]};
        end else if (inst_type == `INST_S) begin
            sext_out     = {20{imm_in[24]}, imm_in[24, 18], imm_in[4:0]};
        end else if (inst_type == `INST_B) begin
            sext_out     = {20{imm_in[24]}, imm_in[24], imm_in[0], imm_in[23], imm_in[18], imm_in[4:1]};
        end else if (inst_type == `INST_U) begin
            sext_out     = {12{imm_in[24]}, imm_in[24, 5]};
        end else if (inst_type == `INST_J) begin
            sext_out     = {12{imm_in[24]}, imm_in[12:5], imm_in[13], imm_in[23:14]};
        end else begin
            sext_out     = 32'b0;
        end
    end

endmodule