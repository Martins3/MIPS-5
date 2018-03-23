`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/11 15:25:43
// Design Name: 
// Module Name: Displays
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


module Displays(
    input clk,
    input [31:0] number,
    output [7:0] AN,
    output [7:0] SEG
    );
    
    wire clk_scan;
    wire [3:0] data;
    
    reg [2:0] selector;
    
    //分频，clk_scan为三极管扫描频率
    Divider t(clk, clk_scan);
    
    //时钟上升沿触发，选择
    always@(posedge clk_scan) begin
        selector <= selector+1;
    end
    
    _7Seg_NumSelect n(selector, number, data);
    _7Seg_Select s(selector, AN);
    _7Seg_Displays d(data, SEG); 
    
endmodule
