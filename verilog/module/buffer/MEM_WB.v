// samely, should be zero
module MEM_WB(
    input syscall,
    input WE,
    input [3:0]RW,
    input [31:0] A,
    input [31:0] w,

    input go,
    input clear,
    input clk,

    output reg syscall_out,
    output reg WE_out,
    output reg [3:0] RW_out,
    output reg [31:0] A_out,
    output reg [31:0] w_out
    );


    MUX_2 #1 mux_0(clear, syscall, 0, syscall_out,0);
    MUX_2 #1 mux_1(clear, WE, 0, WE_out,0);
    MUX_2 #4 mux_2(clear, RW, 0, RW_out,0);
    MUX_2 #32 mux_3(clear, A, 0, A_out, 0);
    MUX_2 #32 mux_4(clear, w, 0, w_out, 0);

    wire syscall_out_t;
    wire WE_out_t;
    wire [3:0] RW_out_t;
    wire [31:0] A_out_t;
    wire [31:0] w_out_t;

    always @(posedge clk) begin
        if(go) begin
            syscall_out_t = syscall_out;
            WE_out_t = WE_out;
            RW_out_t = RW_out;
            A_out_t = A_out;
            w_out_t = w_out;
        end
    end
endmodule