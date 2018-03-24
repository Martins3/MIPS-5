// maybe there are bugs about instruction_32_left2_temp
`timescale 1ns / 1ps
module npc_generator(
    input [31:0] instruction,
    input [31:0] A,
    input [11:0] pc_4,
    input condi_suc,
    input PC_MUX_2,
    input PC_MUX_3,

    output [11:0] npc
    );

    wire[31:0] pc_32;
    wire[27:0] instruction_26_left2;
    wire[31:0] instruction_32_left2;
    wire[31:0] instruction_32_left2_temp;
    wire [31:0] j_im16;
    wire [31:0] j_im26;
    
    wire [31:0]mux_out1;
    wire [31:0]mux_out2;    

    wire [31:0] npc_32;

    // from top to down three line
    assign pc_32 = {{20{1'b0}} , pc_4};
    assign instruction_26_left2 = {instruction[25:0], 2'b00};
    assign instruction_32_left2_temp =  { {16{instruction[15]}} , {instruction[15:0]} };
    assign instruction_32_left2 =  {instruction_32_left2_temp[29:0], 2'b00};
 

    // two jump value
    assign j_im26 = {pc_32[3:0], instruction_26_left2};
    assign j_im16 = instruction_32_left2 + pc_32; 

    // some mux operation

    MUX_2 #32 condi_mux(condi_suc, pc_32, j_im16, mux_out1, 1'b0);

    MUX_2 #32 mux_2(PC_MUX_2, j_im26, mux_out1, mux_out2, 1'b0);

    MUX_2 #32 mux_3(PC_MUX_3, mux_out2, A, npc_32, 1'b0);

    assign npc = npc_32[11:0];


endmodule

