`include "global_config.vh"
`include "cpu.vh"

module writeback(
    // ctrl
    input   wire [4:0]      inst_type,
    input   wire            if_load_inst,
    input   wire            flush_pc,
    // alu
    input   wire [31:0]     alu_out,
    // dram
    input   reg  [31:0]     dram_rd_data,
    // pc
    input   wire [31:0]     pc,

    output  reg  [31:0]     rf_wr_data           
);

    always @(*) begin
        if (if_load_inst) begin
            rf_wr_data      = dram_rd_data;
        end else if (flush_pc | (inst_type == `INST_J)) begin
            // jalr && jal
            rf_wr_data      = pc + 32'd4;
        end else begin
            rf_wr_data      = alu_out;
        end
    end
endmodule