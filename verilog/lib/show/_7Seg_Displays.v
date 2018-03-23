`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/11 08:42:29
// Design Name: 
// Module Name: _7Seg_Displays
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//该模块实现单一数码管单元显示数字0~F，输入为4bits的数字，控制数码管的显示
module _7Seg_Displays(
    input [3:0] NUM,
    output reg [7:0] SEG
    );
    always@(NUM[3:0]) begin
        case(NUM[3:0])
            4'b0000: SEG[7:0] = 8'b11000000;
            4'b0001: SEG[7:0] = 8'b11111001;
            4'b0010: SEG[7:0] = 8'b10100100;
            4'b0011: SEG[7:0] = 8'b10110000;
            4'b0100: SEG[7:0] = 8'b10011001;
            4'b0101: SEG[7:0] = 8'b10010010;
            4'b0110: SEG[7:0] = 8'b10000010;
            4'b0111: SEG[7:0] = 8'b11111000;
            4'b1000: SEG[7:0] = 8'b10000000;
            4'b1001: SEG[7:0] = 8'b10011000;
            4'b1010: SEG[7:0] = 8'b10001000;
            4'b1011: SEG[7:0] = 8'b10000011;
            4'b1100: SEG[7:0] = 8'b11000110;
            4'b1101: SEG[7:0] = 8'b10100001;
            4'b1110: SEG[7:0] = 8'b10000110;
            4'b1111: SEG[7:0] = 8'b10001110;
        endcase
    end
endmodule
