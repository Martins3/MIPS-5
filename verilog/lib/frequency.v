module frequency_switch(primitive_clk, clk, clk_switch);
input primitive_clk;
input clk_switch;
output reg clk = 0;
parameter p1=5000000;
// parameter p2=100;
reg[32:0] counter_M=0;
// reg[32:0] counter_N=0;
always @(posedge primitive_clk)  
begin  
    if(clk_switch==0)
    begin
        if(counter_M==(p1/2-1))
        begin
            counter_M = 0;
            clk = ~clk;
        end                  
        counter_M= counter_M + 1;
    end
    else
    begin
        // if(counter_N==(p2/2-1))
        // begin
        //     counter_N = 0;
            clk = ~clk;
        // end                  
        // counter_N= counter_N + 1;
    end
end 
endmodule
