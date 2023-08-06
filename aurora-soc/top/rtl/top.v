module top(
    input   wire            clk,
    input   wire            rst_n
);
    cpu u_cpu(
        .clk(clk),
        .rst_n(rst_n)
    );
endmodule