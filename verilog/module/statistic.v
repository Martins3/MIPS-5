
`timescale 1ns / 1ps
module statistic(
    input [31:0] A,
    input [31:0] B,
    input clk,
    input rst,
    input syscall_t,
    input condi_suc,
    input un_branch_t,
    input branch_t,
    input strong_halt,

    // output for convenience,  bit width set as 32
    output reg [31:0] total_cycles,
    output reg [31:0] uncondi_num,
    output reg [31:0] condi_num,
    output reg [31:0] condi_suc_num,
    output reg [31:0] SyscallOut
    );

    // there are slightly different form the logisim
    wire is_show;

    assign is_show = (A != 32'd10) && (A != 32'd50) && syscall_t;

    initial begin
        total_cycles = 0;
        uncondi_num = 0;
        condi_num = 0;
        condi_suc_num = 0;
        SyscallOut = 0;
    end
    


    always @(posedge clk) begin
      if(rst) begin
        total_cycles <= 0;
        uncondi_num <= 0;
        condi_num <= 0;
        condi_suc_num <= 0;
        SyscallOut <= 0;
      end else begin
        if(strong_halt) begin
            total_cycles = total_cycles + 1;
        end
    
        if(strong_halt & un_branch_t) begin
            uncondi_num = uncondi_num + 1;
        end
    
        if(strong_halt & branch_t) begin
            condi_num = condi_num + 1;
        end

        if(strong_halt & condi_suc) begin
            condi_suc_num = condi_suc_num + 1;
        end

        
        if(is_show) begin
            SyscallOut = B;
        end

      end
    end
    

endmodule

