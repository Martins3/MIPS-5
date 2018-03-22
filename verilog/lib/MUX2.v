`timescale 1ns / 1ps

module MUX_2#(parameter width = 32)(addr,in0,in1,out,enable);
input addr;
input[width-1:0] in0,in1;
input enable;
output reg[width-1:0] out;

always@(addr or in0 or in1 or enable )
begin
    if(!enable)
        case (addr)
          1'b0:out=in0;
          1'b1:out=in1;
        endcase
    else
        out=0;
end
endmodule
