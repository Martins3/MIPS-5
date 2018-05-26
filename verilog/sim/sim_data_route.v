`timescale 1ns / 1ps
module sim_data_route(); 
    reg clk1;

    reg [5:0]ram_addr_dispaly;
    reg rst; 
    reg frequency; 
    reg[2:0] display; 
    reg continue;
    reg is_benchmark;
    wire [7:0] AN;
    wire [7:0] SEG;

    initial
    begin
        clk1 = 0;
        ram_addr_dispaly = 5'b000000;
        rst = 0;
        frequency = 1;
        display = 3'b000;
        continue = 0;
        is_benchmark = 1;

        # 20000 continue = 1;
        # 1 continue = 0;

        # 10000 continue = 1;
        # 1 continue = 0;

        # 10000 continue = 1;
        # 1 continue = 0;

        # 10000 continue = 1;
        # 1 continue = 0;

        # 100 rst = 1;
        # 100 rst = 0;
    end
     
    always #1 clk1 <= ~clk1;

    data_route data_route_0(clk1, ram_addr_dispaly, rst, frequency, display, continue, is_benchmark, AN, SEG);

    
    
    
endmodule