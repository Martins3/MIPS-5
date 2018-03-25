`timescale 1ns / 1ps
module IM(
	A,
	D_out
    );

	input [9:0] A;
	output [31:0] D_out;

	reg [31:0] data [1023:0];	// 256x31 data

	integer i;
	initial begin
		for (i=0;i<1024;i=i+1) data[i] = 'h00000000;
	end

	initial $readmemh("/home/martin/X-Brain/sys_design/documents/cc/verilog/test/benchmark_ccmb.hex", data);

	assign D_out = data[A];

endmodule
