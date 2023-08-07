`timescale 1ns / 1ps

`define SIM_CYCLE 60

module top_tb;

    parameter CYCLE = 20;

    reg clk     = 1'b0;
    reg rst_n   = 1'b0;

    initial begin            
        $dumpfile("top_tb.vcd");        
        $dumpvars(0, top_tb);    
    end

    initial begin
        # (CYCLE * 2) begin
            $readmemh("./test.dat", u_top.u_cpu.u_d_irom.mem, 0, 4);
        end

        # (CYCLE * 4) begin		  
			rst_n   <= 1'b1;
		end
		# (CYCLE * `SIM_CYCLE) begin 
			$finish;
		end
    end

    top u_top(
        .clk(clk),
        .rst_n(rst_n)
    );

    always # (CYCLE / 2) clk    <= ~clk;

endmodule