
module data_route(
    input clk1, 
    input ram_addr[5:0],
    input rst, 
    input frequency, 
    input restart, 
    input[2:0] display, 
    
    output [7:0] AN, 
    output [7:0] SEG

    );


//////////////////////////////Common Operation//////////////////////////////////
    // frequency exchange !
    wire clk; 
    frequency_switch frequency_switch_0(clk1, clk, frequency);
////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////IF Area////////////////////////////////////////
    // pc 
    wire [11:0]pc;
    wire [9:0]addr;
    wire [11:0] pc_4;
    assign addr = pc[11:2];
    assign pc_4 = pc + 4;

    // IM
    wire [31:0] instruction;
    IM im(addr, instruction);
////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////IF Area////////////////////////////////////////
    wire [11:0] pc_4_ID;
    wire [31:0] instruction_ID;
    IF_ID if_id(pc_4, instruction, ****, ****, ****, clk, pc_4_ID, instruction_ID);
    // IF_ID if_id(pc_4, instruction, clear, go_one, go_two, clk, pc_4_ID, instruction_ID);
    wire [1:0]rA_t;
    module RA_ctrl(instruction_ID, rA_t);

    wire[4:0] rA;
    wire[4:0] rB;
    read_reg_ctrl read_reg_ctrl_0(instruction_ID, rA_t, rA, rB);
    // Registers registers(rA, rB, rW, WE, w, clk, A, B);
    wire[31:0] A_ori;
    wire[31:0] B_ori;
    Registers registers(rA, rB, **, **, **, clk, A_ori, B_ori);
    wire A_ALU;
    wire B_ALU;
    wire A_MEM;
    wire B_MEM;
    wire bubble;
    redirection redirection_0(rA, rB, rw_exe, WE_exe_alu, WE_exe_alu, WE_exe_mem, rw_mem, WE_rw,
    A_ALU, B_ALU, A_MEM, B_MEM, bubble); // 通道名

    wire [3:0]redirection_ctrl_ID;
    assign redirection_ctrl_ID = {{B_MEM},{B_ALU}, {A_MEM}, {A_ALU}};
////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////EXE Area///////////////////////////////////////
wire [31:0] A_EXE;
wire [31:0] B_EXE;
wire [31:0] instruction_EXE;
wire [31:0] pc_4_EXE;
wire [3:0] redirect_ctrl;
ID_EX id_ex(pc_4_ID, instruction_ID, A_ori, B_ori, redirect_ctrl_ID, go, clear_one, clear_two, clk,
pc_4_EXE, instruction_EXE, A_EXE, B_EXE, redirect_ctrl);
// go clear_one clear_two 

// should we change the instruction in the verilog
wire [1:0]rW_t;
wire WE;
wire [1:0]w_t; // choose which word to wirte
wire [1:0]Y;
wire [3:0]alu_s;
wire PC_MUX_2;
wire PC_MUX_3;
wire blez;
wire beq;
wire bne;
wire syscall;
wire RAM_STO;
wire RAM_LOAD;
wire hald_word;
wire branch;
wire unbranch;
wire syscall;
controller controller_0(instruction_EXE, 
rW_t, WE, w_t, Y, alu_s PC_MUX_2, PC_MUX_3, blez, beq, bne, RAM_STO, RAM_LOAD, hald_word, branch, unbranch, syscall);


// signal used in many times
// syscall rW_t WE w_t 


////////////////////////////////////////////////////////////////////////////////

endmodule
