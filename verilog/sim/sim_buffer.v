`timescale 1ns / 1ps
module sim_buffer(); 
    reg [11:0] pc_4;
    reg [31:0] instruction;

    reg clear;
    reg go_one;
    reg go_two;
    reg clk;

    wire [11:0] pc_4_out;
    wire [31:0] instruction_out;
    initial begin
        clk = 0;
        pc_4 = 12'b0000_0000_1111;
        instruction = 32'h0000_10000;
        clear = 0;
        go_one = 1;
        go_two = 1;
        # 50 clear = 1;
        # 20 clear = 0;
    end
    
     
    always #1 clk <= ~clk;
    
IF_ID if_id(pc_4, instruction, clear, go_one, go_two, clk, 
pc_4_out, instruction_out);

    
endmodule