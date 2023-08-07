`include "global_config.vh"
`include "cpu.vh"

module pc(
    input   wire            clk,
    input   wire            rst_n,
    // jalr
    input   wire [31:0]     new_pc,
    input   wire            flush_pc,
    // br inst
    input   wire [31:0]     sext_out,
    input   wire            alu_out,
    input   wire            if_br_inst,
    // jal
    input   wire            if_jal_inst,
    // pc
    output  reg  [31:0]     pc
);

    wire br_taken = (if_br_inst & alu_out) | if_jal_inst;
    wire [31:0] offset = br_taken ? sext_out : 32'd4;

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == `RESET_EDGE_) begin
            pc      <= `RESET_PC;
        end else begin
            if (flush_pc) begin
                pc  <= new_pc;
            end else begin
                pc  <= pc + offset;
            end
        end
    end

endmodule