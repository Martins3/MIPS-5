module ID_EXE(
    input [11:0] pc_4
    input [31:0] instruction,
    input [31:0] A,
    input [31:0] B,
    input [3:0] redirect_ctrl,

    input go,
    input clear_one, 
    input clear_two,
    input clk,

    output reg [11:0] pc_4_out,
    output reg [31:0] instruction_out,
    output reg [31:0] A_out,
    output reg [31:0] B_out,
    output reg [3:0] redirect_ctrl_out,
    );

    wire clear;
    assign clear = clear_one | clear_two;
    
    always @(posedge clk) begin
        if(go) begin

        MUX_2 #12 mux_1(clear, pc_4, 0, pc_4_out, 0);
        MUX_2 #32 mux_2(clear, instruction, 0, instruction_out,0);
        MUX_2 #32 mux_3(clear, A, 0, A_out, 0);
        MUX_2 #32 mux_4(clear, B, 0, B_out, 0);
        MUX_2 #4 mux_5(clear, redirect_ctrl, 0, redirect_ctrl_out,0);
        end
    end
endmodule