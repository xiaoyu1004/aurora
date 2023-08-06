`include "global_config.vh"
`include "cpu.vh"

module d_dram(
    input   wire            clk,
    input   wire [11:0]     rw_addr,
    input   wire            wr_en,
    input   reg  [31:0]     wr_data
    output  reg  [31:0]     rd_data
);

    reg [31:0] mem [`RAM_DEPTH-1 : 0]

    // read
    assign rd_data = mem[rw_addr];

    // write
    always @(posedge clk or negedge rst_n) begin
        if (wr_en) begin
            mem[rw_addr]    <= wr_data;
        end
    end

endmodule