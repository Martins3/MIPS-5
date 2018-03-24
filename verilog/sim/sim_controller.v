`timescale 1ns / 1ps
module sim_controller(); 
    reg[31:0] ins;
    
   


    wire [1:0]rW_t_exe;
    wire WE_exe;
    wire [1:0]wc_exe; // choose which word to wirte
    wire [1:0]Y_t;
    wire [3:0]alu_s;
    wire PC_MUX_2;
    wire PC_MUX_3;
    wire blez;
    wire beq;
    wire bne;
    wire RAM_STO_exe;
    wire RAM_LOAD_exe;
    wire half_word_exe;
    wire branch;
    wire unbranch;
    wire syscall_t_exe;
    controller controller_0(ins, 
    rW_t_exe, WE_exe, wc_exe, Y_t, alu_s, PC_MUX_2, PC_MUX_3, blez, beq, bne, RAM_STO_exe, RAM_LOAD_exe, half_word_exe, branch, unbranch, syscall_t_exe);

    initial
    begin
        ins = 0;
    end
    
endmodule