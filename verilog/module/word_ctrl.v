module word_ctrl(
    input wc,
    input half_word_t,
    input [31:0] D,

    output [31:0] D_out
    );

    wire [15:0] low;
    wire [15:0] high;
    wire [15:0] half;
    wire [31:0] half_ext;

    assign high = D[31:16];
    assign low = D[15:0];
    assign half_ext = {{16{half[15]}}, half};
    
    MUX_2 #1 mux_1(wc, low, high, half, 1'b0);
    MUX_2 #32 mux_2(half_word_t, D, half_ext, D_out ,1'b0);
    
endmodule

