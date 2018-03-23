`timescale 1ns / 1ps

module Data_Choose(
    input [2:0] display_type,
    input [31:0] memory,
    input [31:0] total,
    input [31:0] conditional_jmp,
    input [31:0] unconditional_jmp,
    input [31:0] successful_conditional_jmp,
    input [31:0] syscall,
    input [31:0] PC,
    input clk,
    output [7:0] AN,
    output [7:0] SEG
    );

    reg [31:0] toshow;
    
	wire [31:0] temp_total;
	wire [31:0] temp_conditional_jmp;
	wire [31:0] temp_unconditional_jmp;
	wire [31:0] temp_successful_conditional_jmp;

    Hex_to_Dec a(total, temp_total);
    Hex_to_Dec b(conditional_jmp, temp_conditional_jmp);
    Hex_to_Dec c(unconditional_jmp, temp_unconditional_jmp);
    Hex_to_Dec d(successful_conditional_jmp, temp_successful_conditional_jmp);

	always @(display_type or memory or temp_total or temp_conditional_jmp or temp_unconditional_jmp or temp_successful_conditional_jmp
		or syscall or PC) begin
		case(display_type[2:0])
			3'b000: toshow = syscall;
			3'b001: toshow = temp_total;
			3'b010: toshow = temp_conditional_jmp;
			3'b011: toshow = temp_unconditional_jmp;
			3'b100: toshow = temp_successful_conditional_jmp;
			3'b101: toshow = PC;
			3'b110: toshow = memory;
			3'b111: toshow = syscall;    //暂时没用，先写成syscall
		endcase
	end
	
	Displays dis(clk, toshow, AN, SEG);
	
endmodule
