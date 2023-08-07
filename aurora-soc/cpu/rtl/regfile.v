`include "global_config.vh"
`include "cpu.vh"

module regfile(
    input   wire            clk,
    input   wire            rst_n,
    // read
    input   wire [4:0]      rd_addr_0,
    input   wire [4:0]      rd_addr_1,
    output  wire [31:0]     rd_data_0,
    output  wire [31:0]     rd_data_1,
    // write
    input   wire [4:0]      wr_addr,
    input   wire            we,
    input   wire [31:0]     wr_data
);

    reg [31:0] gpr [31:0];

    // r0
    assign rd_data_0 = (rd_addr_0 == 5'b0) ? 32'b0 : (wr_addr == rd_addr_0 && we) ? wr_data : gpr[rd_addr_0];
    // r2
    assign rd_data_1 = (rd_addr_1 == 5'b0) ? 32'b0 : (wr_addr == rd_addr_1 && we) ? wr_data : gpr[rd_addr_1];

    integer i;

    // write
    always @(posedge clk or negedge rst_n) begin
        if (rst_n == `RESET_EDGE_) begin
            for (i = 0; i < 32; i = i + 1) begin
                gpr[i]      <= 32'b0; 
            end
        end else if (we) begin
            gpr[wr_addr]      <= wr_data;
        end
    end

endmodule