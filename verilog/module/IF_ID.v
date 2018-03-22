module RA_ctrl(
    input [11:0] pc_4
    input [31:0] instruction,

    input clear,
    input go_one,
    input go_two,

    output reg [11:0] pc_4_out,
    output reg [31:0] instruction_out
    );

    wire go;
    assign go = go_one | go_two;

    MUX_2 #12 mux_1(clear,pc, in1,out,enable);
    MUX_2 #32 mux_1(clear,pc, in1,out,enable);
endmodule