
`timescale 1ns / 1ps
module redirection_handler(
    input [31:0] A_ori,
    input [31:0] B_ori,
    input [31:0] alu_out,
    input [31:0] mem_out,
    input [3:0] redirection_ctrl,
    

    output [31:0] A,
    output [31:0] B
    );

    wire [31:0] A_mem;
    wire [31:0] B_mem;
    MUX_2 #32 mux_0(redirection_ctrl[1], A_ori, mem_out, A_mem, 1'b0);
    MUX_2 #32 mux_1(redirection_ctrl[0], A_mem, alu_out, A, 1'b0);

    MUX_2 #32 mux_2(redirection_ctrl[3], B_ori, mem_out, B_mem, 1'b0);
    MUX_2 #32 mux_3(redirection_ctrl[2], B_mem, alu_out, B, 1'b0);
endmodule