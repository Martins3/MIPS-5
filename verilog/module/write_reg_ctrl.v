module write_reg_ctrl(
    input [1:0] rW_t,
    input [31:0] instruction,

    output [4:0] rw
    );

    wire [4:0] rs;
    wire [4:0] rt;
    
    assign rs = instruction[15:11];
    assign rt = instruction[20:16];

    MUX_4#5 mux_0(rW_t, rs, 5'b00000, 5'b11111, rt, rw,  5'b00000);

endmodule