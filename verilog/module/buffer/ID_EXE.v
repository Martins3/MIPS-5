
`timescale 1ns / 1ps
module ID_EXE(
    input [11:0] pc_4,
    input [31:0] instruction,
    input [31:0] A,
    input [31:0] B,
    input [3:0] redirect_ctrl,
    input [11:0] addr,

    input go,
    input clear, 
    input clk,

    output reg [11:0] pc_4_out,
    output reg [31:0] instruction_out,
    output reg [31:0] A_out,
    output reg [31:0] B_out,
    output reg [3:0] redirect_ctrl_out,
    output reg [11:0] addr_out
    );
    
    initial begin
        pc_4_out = 0;
        instruction_out = 0;
        A_out = 0;
        B_out = 0;
        redirect_ctrl_out = 0;
        addr_out = 0;
    end

    
    wire [11:0] pc_4_out_t;
    wire [31:0] instruction_out_t;
    wire [31:0] A_out_t;
    wire [31:0] B_out_t;
    wire [3:0] redirect_ctrl_out_t;
    wire [11:0] addr_out_t;

    MUX_2 #12 mux_1(clear, pc_4, 12'h000, pc_4_out_t, 1'b0);
    MUX_2 #32 mux_2(clear, instruction, 32'h0000_0000, instruction_out_t, 1'b0);
    MUX_2 #32 mux_3(clear, A, 32'h0000_0000, A_out_t, 1'b0);
    MUX_2 #32 mux_4(clear, B, 32'h0000_0000, B_out_t, 1'b0);
    MUX_2 #4 mux_5(clear, redirect_ctrl, 4'h0000, redirect_ctrl_out_t, 1'b0);
    MUX_2 #12 mux_100(clear, addr, 32'h000, addr_out_t, 1'b0);

    always @(posedge clk) begin
        if(go) begin
            pc_4_out = pc_4_out_t;
            instruction_out = instruction_out_t;
            A_out = A_out_t;
            B_out = B_out_t;
            redirect_ctrl_out = redirect_ctrl_out_t;
            addr_out = addr_out_t;
        end
    end
endmodule