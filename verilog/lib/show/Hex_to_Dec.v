`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 15:03:19
// Design Name: 
// Module Name: Hex_to_Dec
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Hex_to_Dec(
	input [31:0] hex,
	output reg [31:0] dec
    );
    
    reg [11:0] temp;
    reg [3:0] Thous;
    reg [3:0] Hund;
    reg [3:0] Tens;
    reg [3:0] Ones;
    integer i;
    
    always@(hex) begin
       Thous = 4'd0;
       Hund = 4'd0;
       Tens = 4'b0;
       Ones = 4'b0;
       
       for(i=11; i>=0; i=i-1) begin
            if(Thous >=5)
              Thous = Thous+3;
            if(Hund >=5)
              Hund = Hund+3;
            if(Tens >=5)
              Tens = Tens+3;
            if(Ones >=5)
              Ones = Ones+3;

            Thous = Thous << 1;
            Thous[0] = Hund[3];

            Hund = Hund << 1;
            Hund[0] = Tens[3];

            Tens = Tens << 1;
            Tens[0] = Ones[3];

            Ones = Ones << 1;
            Ones[0] = hex[i];
       end
       dec[31:0] = {16'b0, Thous, Hund, Tens, Ones};
    end
    

endmodule
