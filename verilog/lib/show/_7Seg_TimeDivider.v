`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/11 16:01:59
// Design Name: 
// Module Name: _7Seg_TimeDivider
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


module Divider#(parameter N = 100_000)(
    input clk,
    output reg clk_N
    );
    
    reg [31:0] counter;
    always@(posedge clk) begin
        counter = counter+1;
        if(counter >=(N/2-1)) begin
            counter <= 0;
            clk_N <= ~clk_N;
        end
    end
endmodule
