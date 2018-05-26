`timescale 1ns / 1ps
module redirection(
    input [4:0] rA,
    input [4:0] rB,

    input [4:0] rw_exe,
    input WE_exe_alu,
    input WE_exe_mem,

    input [4:0] rw_mem,
    input WE_mem,

    output A_ALU,
    output B_ALU,
    output A_MEM,
    output B_MEM,
    output bubble
    );
    
    assign A_ALU = (rA == rw_exe) && (rw_exe != 4'b0000) && WE_exe_alu;
    assign B_ALU = (rB == rw_exe) && (rw_exe != 4'b0000) && WE_exe_alu;


    assign A_MEM = (rA == rw_mem) && (rw_mem != 4'b0000) && WE_mem;
    assign B_MEM = (rB == rw_mem) && (rw_mem != 4'b0000) && WE_mem;

    assign bubble = ((rA == rw_exe) || (rB == rw_exe)) && WE_exe_mem && (rw_exe != 4'b0000);

endmodule

