module read_reg_ctrl(
    input [31:0]instruction,
    input [1:0] rA_t,

    output [4:0] rA,
    output [4:0] rB

    );
    
    wire [4:0] rs;
    wire [4:0] rt;

    assign rs = instruction[20:16];
    assign rt = instruction[25:21];

    MUX_4 #5 mux_left(rA_t, rt, 5'b00010,5'b00000, rs, rA, 0);
    MUX_4 #5 mux_right(rA_t, rs, 5'b00100, 5'b00000, rt, Y, rB ,0);
    
endmodule

