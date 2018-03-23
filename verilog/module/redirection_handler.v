module redirection_handler(
    input [31:0] A_ori,
    input [31:0] B_ori,
    input [31:0] alu_out,
    input [31:0] mem_out,
    input [3:0] redirection_ctrl,
    

    output reg [31:0] A,
    output reg [31:0] B
    );

    wire [31:0] A_mem;
    wire [31:0] B_mem;
    MUX_2 #32 mux_0(redirection_ctrl[1], A_ori, mem_out, A_mem, 32'h0000_0000);
    MUX_2 #32 mux_0(redirection_ctrl[0], A_mem, alu_out, A, 32'h0000_0000);

    MUX_2 #32 mux_0(redirection_ctrl[3], B_ori, mem_out, B_mem, 32'h0000_0000);
    MUX_2 #32 mux_0(redirection_ctrl[2], B_mem, alu_out, B, 32'h0000_0000);
endmodule