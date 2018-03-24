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

    output reg [31:0] instruction_out,
    output reg [14:0] ctrl_msg_out,
    output reg [31:0] alu_out,
    output reg [31:0] A_out,
    output reg [31:0] B_out
    );

    wire [31:0] instruction_out_t;
    wire [14:0] ctrl_msg_out_t;
    wire [31:0] alu_out_t;
    wire [31:0] A_out_t;
    wire [31:0] B_out_t;

    MUX_2 #32 mux_0(clear, instruction, 0, instruction_out_t, 1'b0);
    MUX_2 #15 mux_1(clear, ctrl_msg, 15'b00000_00000_00000, ctrl_msg_out_t,1'b0);
    MUX_2 #32 mux_2(clear, alu, 0, alu_out_t,1'b0);
    MUX_2 #32 mux_3(clear, A, 0, A_out_t, 1'b0);
    MUX_2 #32 mux_4(clear, B, 0, B_out_t, 1'b0);

    always @(posedge clk) begin
        if(go) begin
            instruction_out = instruction_out_t;
            ctrl_msg_out = ctrl_msg_out_t;
            alu_out = alu_out_t;
            A_out = A_out_t;
            B_out = B_out_t;
        end
    end
endmodule