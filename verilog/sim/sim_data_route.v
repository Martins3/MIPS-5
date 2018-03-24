`timescale 1ns / 1ps
module sim_data_route(); 
    reg clk1;

    reg [5:0]ram_addr_dispaly;
    reg rst; 
    reg frequency; 
    reg[2:0] display; 
    
    wire [7:0] AN;
    wire [7:0] SEG;

    initial
    begin
        clk1 = 0;
        ram_addr_dispaly = 5'b000000;
        rst = 0;
        frequency = 1;
        display = 3'b000;
//        # 5 rst = 0;
    end
     
    always #1 clk1 <= ~clk1;

    data_route data_route_0(clk1, ram_addr_dispaly, rst, frequency, display, AN, SEG);

    
    
    
endmodule