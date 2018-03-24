`timescale 1ns / 1ps
module sim_statistic(); 
    reg clk;
    reg [31:0] A;
    reg [31:0] B;
    reg rst = 1;
    reg syscall_t = 1;
    reg condi_suc = 1;
    reg un_branch_t = 1;
    reg branch_t = 1;
    reg strong_halt = 1;


wire [31:0]total_cycles;
wire [31:0]uncondi_num;
wire [31:0]condi_num;
wire [31:0]condi_suc_num;
wire [31:0]SyscallOut;
wire halt;
    initial
    begin
        
        clk = 0;
        A = 0;
          B <= 123;
          rst = 1;
       #10 rst <= 0;
     
    

    end
     
    	always #1 clk <= clk + 1;

   

    
statistic my_s( A, B, clk,rst,syscall_t,condi_suc,un_branch_t,branch_t,strong_halt,
 total_cycles, uncondi_num, condi_num, condi_suc_num, SyscallOut, halt);
    
    
endmodule