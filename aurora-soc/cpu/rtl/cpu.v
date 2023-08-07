`include "global_config.vh"
`include "cpu.vh"

module cpu(
    input   wire            clk,
    input   wire            rst_n    
);
    // pc   
    wire            flush_pc;
    wire            if_jal_inst;
    wire [31:0]     pc;      

    // irom
    wire [31:0]      inst;

    // regfile
    wire [31:0]     rf_rd_data_0;
    wire [31:0]     rf_rd_data_1;
    wire            rf_we;
    wire [31:0]     rf_wr_data;

    // sext
    wire [2:0]      inst_type;
    wire            if_shift_imm_inst;
    wire [31:0]     sext_out; 

    // alu
    wire [3:0]      alu_op_type;
    wire [31:0]     alu_out;

    // dram
    wire            dram_wr_en;
    wire [31:0]     dram_rd_data;

    // writeback
    wire            if_load_inst;

    // pc
    pc u_pc(
        .clk(clk),
        .rst_n(rst_n),
        .new_pc(alu_out),
        .flush_pc(flush_pc),
        .sext_out(sext_out),
        .alu_out(alu_out),
        .if_br_inst(if_br_inst),
        .if_jal_inst(if_jal_inst),
        .pc(pc)
    );

    // irom
    d_irom u_d_irom(
        .addr(pc[13:2]),
        .inst(inst)
    );

    // regfile
    regfile u_regfile(
        .clk(clk),
        .rst_n(rst_n),
        .rd_addr_0(inst[19:15]),
        .rd_addr_1(inst[24:20]),
        .rd_data_0(rf_rd_data_0),
        .rd_data_1(rf_rd_data_1),
        .wr_addr(inst[11:7]),
        .we(rf_we),
        .wr_data(rf_wr_data)
    );

    // sext
    sext u_sext(
        .imm_in(inst[31:7]),
        .inst_type(inst_type),
        .if_shift_imm_inst(if_shift_imm_inst),
        .sext_out(sext_out)
    );

    // alu
    alu u_alu(
        .rd_data_0(rf_rd_data_0),
        .rd_data_1(rf_rd_data_1),
        .sext_out(sext_out),
        .inst_type(inst_type),
        .alu_op_type(alu_op_type),
        .alu_out(alu_out)
    );

    // dram
    d_dram u_d_dram(
        .clk(clk),
        .rw_addr(alu_out[13:2]),
        .wr_en(dram_wr_en),
        .wr_data(rf_rd_data_1),
        .rd_data(dram_rd_data)
    );

    // writeback
    writeback u_writeback(
        .inst_type(inst_type),
        .if_load_inst(if_load_inst),
        .flush_pc(flush_pc),
        .alu_out(alu_out),
        .dram_rd_data(dram_rd_data),
        .pc(pc),
        .rf_wr_data(rf_wr_data)
    );

    // ctrl
    ctrl u_ctrl(
        .inst(inst),
        .flush_pc(flush_pc),
        .if_br_inst(if_br_inst),
        .if_jal_inst(if_jal_inst),
        .rf_we(rf_we),
        .inst_type(inst_type),
        .if_shift_imm_inst(if_shift_imm_inst),
        .alu_op_type(alu_op_type),
        .dram_wr_en(dram_wr_en),
        .if_load_inst(if_load_inst)
    );

endmodule