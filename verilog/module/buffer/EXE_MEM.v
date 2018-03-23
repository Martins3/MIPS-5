// clear should be assigned as 0
// for nobody should clear this buffer

module EXE_MEM(
    input [31:0] instruction,
    input [14:0] ctrl_msg,
    input [31:0] alu,
    input [31:0] A,
    input [31:0] B,

    input go,
    input clear,
    input clk,

    output reg [11:0] instruction_out,
    output reg [14:0] ctrl_msg_out,
    output reg [31:0] alu_out,
    output reg [31:0] A_out,
    output reg [31:0] B_out,
    );


    always @(posedge clk) begin
        if(go) begin
        MUX_2 #32 mux_0(clear, instruction, 0, instruction_out,0);
        MUX_2 #32 mux_1(clear, ctrl_msg, 0, ctrl_msg_out,0);
        MUX_2 #32 mux_2(clear, alu, 0, alu_out,0);
        MUX_2 #32 mux_3(clear, A, 0, A_out, 0);
        MUX_2 #32 mux_4(clear, B, 0, B_out, 0);
        end
    end
endmodule