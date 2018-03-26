`timescale 1ns / 1ps
module stop_ctrl(
    input clk, 
    input continue,
    input stop_g,
    output stop
);
    wire n_stop_g;
    reg mem;
    assign n_stop_g = !stop_g;
    assign stop = !mem;
    

    initial  begin
        mem = 0;
    end


    always@(posedge clk or posedge continue)
        begin
            if(continue) begin
                mem <= 0;
            end else if(stop) begin
                mem <= n_stop_g;
            end
        end
endmodule
    