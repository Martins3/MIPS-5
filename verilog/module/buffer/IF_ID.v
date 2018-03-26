
`timescale 1ns / 1ps
module IF_ID(
    input [11:0] pc_4,
    input [31:0] instruction,
    input [11:0] addr,
    input p,


    input clear,
    input go_one,
    input go_two,
    input clk,

    output reg [11:0] pc_4_out,
    output reg [31:0] instruction_out,
    output reg [11:0] addr_out,
    output reg p_out
    );

    wire go;
    assign go = go_one & go_two;
    initial begin
        pc_4_out = 0;
        instruction_out = 0;
        addr_out = 0;
        p_out = 0;
    end
    
    wire [11:0] pc_4_out_t;
    wire [31:0] instruction_out_t;
    wire [11:0] addr_out_t;
    wire p_out_t;
    
    MUX_2 #12 mux_1(clear, pc_4, 12'h000, pc_4_out_t, 1'b0);
    MUX_2 #32 mux_2(clear, instruction, 32'h0000_0000, instruction_out_t, 1'b0);
    MUX_2 #12 mux_100(clear, addr, 12'h000, addr_out_t, 1'b0);
    MUX_2 #1 mux_101(clear, p, 1'b0, p_out_t, 1'b0);

   

    always @(posedge clk) begin
        if(go) begin
            pc_4_out = pc_4_out_t;
            instruction_out = instruction_out_t;
            addr_out = addr_out_t;
            p_out = p_out_t;
        end
    end
endmodule