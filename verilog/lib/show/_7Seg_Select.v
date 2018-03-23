`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/11 15:19:40
// Design Name: 
// Module Name: _7Seg_Select
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

//本模块控制8个7段数码管哪一个亮，其实是一个3-8译码器
module _7Seg_Select(
    input [2:0] in,
    output reg [7:0] out
    );
    always@(in) begin
        case(in[2:0])
             3'b000:out[7:0] = 8'b11111110;
             3'b001:out[7:0] = 8'b11111101;
             3'b010:out[7:0] = 8'b11111011;
             3'b011:out[7:0] = 8'b11110111;
             3'b100:out[7:0] = 8'b11101111;
             3'b101:out[7:0] = 8'b11011111;
             3'b110:out[7:0] = 8'b10111111;
             3'b111:out[7:0] = 8'b01111111;
        endcase
    end
endmodule
