`timescale 1ns / 1ps
module sim_BHT();
    reg clk;

    reg [11:0] insert_ins_addr;
    reg [11:0]insert_ins_next_addr;
    reg is_branch;
    reg is_suc;

	reg [11:0] query_ins_addr;
    wire [11:0] prediect_adrr;
    wire prediect_jump;
    initial begin

    clk = 0;

    insert_ins_addr = 4;
    insert_ins_next_addr = 12;
    is_branch = 1;
    is_suc = 1;

	query_ins_addr = 0;
    
    # 20 insert_ins_next_addr = 16;
    # 20 insert_ins_addr = 8;
    # 20 insert_ins_addr = 8;
    # 20 insert_ins_addr = 8;
    # 20 insert_ins_addr = 8;
    # 20 insert_ins_addr = 8;

    # 30 query_ins_addr = 4;
    # 30 query_ins_addr = 8;
    end


    always #1 clk <= ~clk;

BHT bht(
    clk,
    insert_ins_addr, insert_ins_next_addr, is_branch, is_suc,

	query_ins_addr,
    prediect_adrr, prediect_jump);
endmodule