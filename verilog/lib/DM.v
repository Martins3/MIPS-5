`timescale 1ns / 1ps

module DM(
	_rA, _rB, D, WE, mode, clr, clk,
	A_out , B_out);

	input [5:0] _rA, _rB;	// rA is read-write but rB is read-only (for display)
	input [31:0] D;			// D will be wrote at address 'rA'
	input [1:0] mode;
	input WE, clr, clk;
	output reg [31:0] A_out, B_out;

	reg [31:0] data [0:63];	// 64x31 data

	integer i;

	wire [5:0] rA, rB;

	assign rA = _rA;
	assign rB = _rB;

	initial begin
		for (i=0; i<64; i=i+1) data[i] <= 'h00000001;
		A_out <= 0;
		B_out <= 0;
	end

	always @(posedge clk or posedge clr) begin
		if (clr) begin
			for (i=0; i<64; i=i+1) data[i] <= 'h00000000;
		end
		else if (WE) begin
			case (mode)		// write
				2'b00:	data[rA] <= D;
				2'b01:	data[rA][15:0] <= D[15:0];
				2'b10:	data[rA][7:0] <= D[7:0];
				default:	data[rA] <= D;
			endcase
		end
	end


	always @(*) begin
		A_out = data[rA];
		B_out = data[rB];
	end

endmodule
