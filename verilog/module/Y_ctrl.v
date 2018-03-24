`timescale 1ns / 1ps
module Y_ctrl(
    input [31:0]instruction,
    input [31:0] B,
    input [1:0] Y_t,

    output [31:0] Y
    );

    wire ori_andi;
    wire [4:0] op;
    wire [15:0] im;
    wire [31:0] signed_im;
    wire [31:0] unsinged_im;
    wire [31:0] shamt;
    wire [31:0] mux_1_out;
    
    assign op = instruction[31: 27];
    assign ori_andi = (op == 5'b00110);

    assign im = instruction[15:0];
    assign shamt = {27'b0, {instruction[10:6]}};
    assign signed_im = {{16{im[15]}}, im};
    assign unsinged_im = {16'b0, im};

    
    MUX_2 #32 mux_1(ori_andi, signed_im, unsinged_im, mux_1_out, 1'b0);
    MUX_4 #32 mux_2(Y_t, B, shamt, 32'h0000_0000, mux_1_out, Y, 1'b0);
    
endmodule

