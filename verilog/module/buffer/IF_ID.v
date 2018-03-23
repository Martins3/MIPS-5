module IF_ID(
    input [11:0] pc_4
    input [31:0] instruction,

    input clear,
    input go_one,
    input go_two,
    input clk,

    output reg [11:0] pc_4_out,
    output reg [31:0] instruction_out
    );

    wire go;
    assign go = go_one | go_two;


    always @(posedge clk) begin
        if(go) begin
        MUX_2 #12 mux_1(clear,pc_4, 0, pc_4_out, enable);
        MUX_2 #32 mux_2(clear, instruction, 0, instruction_out,out,enable);
        end
    end
endmodule