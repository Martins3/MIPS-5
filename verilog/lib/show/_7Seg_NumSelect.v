`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/11 16:16:21
// Design Name: 
// Module Name: _7Seg_NumSelect
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


module _7Seg_NumSelect(
    input [2:0] selector,
    input [31:0] data_32,
    output reg [3:0] data_4
    );
    always@(selector[2:0] or data_32) begin
        case(selector[2:0])
            3'b000: data_4 = data_32[3:0];
            3'b001: data_4 = data_32[7:4];
            3'b010: data_4 = data_32[11:8];
            3'b011: data_4 = data_32[15:12];
            3'b100: data_4 = data_32[19:16];
            3'b101: data_4 = data_32[23:20];
            3'b110: data_4 = data_32[27:24];
            3'b111: data_4 = data_32[31:28];
        endcase
    end
endmodule
