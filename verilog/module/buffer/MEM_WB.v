// samely, should be zero
`timescale 1ns / 1ps
module MEM_WB(
    input syscall,
    input WE,
    input [4:0]RW,
    input [31:0] A,
    input [31:0] w,

    input go,
    input clear,
    input clk,

    output reg syscall_out,
    output reg WE_out,
    output reg [4:0] RW_out,
    output reg [31:0] A_out,
    output reg [31:0] w_out
    );

    wire syscall_out_t;
    wire WE_out_t;
    wire [4:0] RW_out_t;
    wire [31:0] A_out_t;
    wire [31:0] w_out_t;

    MUX_2 #1 mux_0(clear, syscall, 1'b0, syscall_out_t,1'b0);
    MUX_2 #1 mux_1(clear, WE, 1'b0, WE_out_t, 1'b0);
    MUX_2 #5 mux_2(clear, RW, 5'b00000, RW_out_t, 1'b0);
    MUX_2 #32 mux_3(clear, A, 32'h0000_0000, A_out_t, 1'b0);
    MUX_2 #32 mux_4(clear, w, 32'h0000_0000, w_out_t, 1'b0);


    always @(posedge clk) begin
        if(go) begin
            syscall_out = syscall_out_t;
            WE_out = WE_out_t;
            RW_out = RW_out_t;
            A_out = A_out_t;
            w_out = w_out_t;
        end
    end
endmodule