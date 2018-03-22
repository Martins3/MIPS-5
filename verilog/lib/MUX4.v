`timescale 1ns / 1ps

module MUX_4#(parameter width = 32)(addr,in0,in1,in2,in3,out,enable);
input[1:0] addr;
input[width-1:0] in0,in1,in2,in3;
input enable;
output reg[width-1:0] out;

always@(addr or in0 or in1 or in2 or in3 or enable )
begin
    if(!enable)
        case (addr)
          2'b00:out=in0;
          2'b01:out=in1;
          2'b10:out=in2;
          2'b11:out=in3;
        endcase
    else
        out=0;
end
endmodule
