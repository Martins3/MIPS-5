`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/11 14:32:00
// Design Name: 
// Module Name: Registers
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


module Registers(
	rA, rB, rW, WE, w, clk,
	A, B
    );
	
	input [4:0] rA;
	input [4:0] rB;
	input [4:0] rW;
	input WE;
	input [31:0] w;
	input clk;

	output [31:0] A;
	output [31:0] B;

	reg [31:0] data [31:0];	// register array 32x32

	assign A = data[rA];
	assign B = data[rB];

	integer i;

	initial begin
		for (i = 0; i < 32; i=i+1) data[i] = 'h00000000;
	end

	always @(posedge clk) begin
		if (WE) begin
			data[rW] = w;
		end
	end


endmodule
