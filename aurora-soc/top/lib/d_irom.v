`include "global_config.vh"
`include "cpu.vh"

module d_irom(
    input   wire [11:0]      addr,
    output  wire [31:0]      inst
);

    reg [31:0] mem [`ROM_DEPTH-1 : 0];

    assign inst = mem[addr];

endmodule