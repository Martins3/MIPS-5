
`timescale 1ns / 1ps
module RA_ctrl(
    input [31:0]instruction,

    output [1:0]R
    );

    wire [5:0]op;
    wire [5:0]funct;
    wire is_R;
    
    assign op = instruction[31:26];
    assign funct = instruction[5:0];
    assign is_R = op[0] | op[1] | op[2] | op[3] | op[4] | op[5]; 

    // 对于的Ra Rb 的控制信号
    assign R = (is_R && (funct == 6'b100000|| funct == 6'b100001|| funct == 6'b100100|| funct == 6'b100010|| funct == 6'b100101|| funct == 6'b100111|| funct == 6'b101010|| funct == 6'b101011)) ? 2'b00: 2'bz, 
           R = (is_R && (funct == 6'b000110 || funct == 6'b000111 || funct == 6'b000000 || funct == 6'b000011 || funct == 6'b000010)) ? 2'b11: 2'bz,
           R = (!is_R) ? 2'b00 : 2'bz, 
           R = (is_R && funct == 6'b001100) ? 2'b01: 2'bz;

endmodule