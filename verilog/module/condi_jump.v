
`timescale 1ns / 1ps
module condi_jump(
    input [31:0] A,
    input [31:0] B,
    input blez,
    input beq,
    input bne,

    output condi_suc
    );

    wire a_equal_b;
    wire a_less_equal_0;
    wire a_not_equal_b;

    assign a_equal_b = (A == B);
    assign a_less_equal_0 = ($signed(A) <= 0);
    assign a_not_equal_b = ~a_equal_b;

    assign condi_suc = (a_equal_b && beq) || (a_not_equal_b && bne) || (a_less_equal_0 && blez);
endmodule

