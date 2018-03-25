`timescale 1ns / 1ps
/**
*input: X		第一个ALU参数
*		Y		第二个ALU参数
*		OP 		ALU计算模式选择参数
*       output:R 计算结果?32?
*		R2		计算结果?32?
*		OF		有符号溢出标?
*		UOF		无符号溢出标?
*		Equal	X和Y是否相等
**/

module ALU(X,Y,OP,R,R2,OF,UOF,Equal);
	input [31:0] X,Y;
    input [3:0] OP;
    output reg [31:0] R,R2;
    output reg OF,UOF;
    output Equal;
    assign Equal = (X === Y);
    always @(X or Y or OP) begin
    	case(OP)
    		0 : begin//逻辑左移
    			R = X << Y[4:0];
    			R2 = 0;
    			OF = 0;
    			UOF = 0;
    		end
    		1 : begin//算术右移
    			R = $signed(X) >>> Y[4:0];
    			R2 = 0;
    			OF = 0;
    			UOF = 0;
    		end
    		2 : begin//逻辑右移
    			R = X >> Y[4:0];
    			R2 = 0;
    			OF = 0;
    			UOF = 0;
    		end
    		3 : begin//有符号乘?
    			{R2,R} = $signed(X) * $signed(Y);
    			OF = 0;
    			UOF = 0;
    		end
    		4 : begin//无符号除?
    			R = X / Y;
    			R2 = X % Y;
    			OF = 0;
    			UOF = 0;
    		end
    		5 : begin//加法
    			R = X + Y;
    			R2 = 0;
    			UOF = (R < X || R < Y);
    			OF = (R > 0 && X < 0 && Y < 0) || (R < 0 && X > 0 && Y > 0);
    		end
    		6 : begin//减法
    			R = X - Y;
    			R2 = 0;
    			UOF = (Y > X);
    			OF = (R > 0 && X < 0 && Y > 0) || (R < 0 && X > 0 && Y < 0);
    		end
    		7 : begin//按位?
    			R = X & Y;
    			R2 = 0;
    			UOF = 0;
    			OF = 0;
    		end
    		8 : begin//按位?
    			R = X | Y;
    			R2 = 0;
    			UOF = 0;
    			OF = 0;
    		end
    		9 : begin//按位异或
    			R = X ^ Y;
    			R2 = 0;
    			UOF = 0;
    			OF = 0;
    		end
    		10 : begin//按位或非
    			R = ~(X | Y);
    			R2 = 0;
    			UOF = 0;
    			OF = 0;
    		end
    		11 : begin//有符号比�?
    			R = $signed(X)<$signed(Y);
    			R2 = 0;
    			UOF = 0;
    			OF = 0;
    		end
    		12 : begin//无符号比�?
    			R = $unsigned(X)<$unsigned(Y);
    			R2 = 0;
    			UOF = 0;
    			OF = 0;
    		end  
    	endcase  		   		
    end
endmodule
