
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

wire [11:0] pc_4_ID;
wire [31:0] instruction_ID;
IF_ID if_id(pc_4, instruction, ****, ****, ****, clk, pc_4_ID, instruction_ID);
// IF_ID if_id(pc_4, instruction, clear, go_one, go_two, clk, pc_4_ID, instruction_ID);
////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////IF Area////////////////////////////////////////
wire [1:0]rA_t;
module RA_ctrl(instruction_ID, rA_t);

wire[4:0] rA;
wire[4:0] rB;
read_reg_ctrl read_reg_ctrl_0(instruction_ID, rA_t, rA, rB);
// Registers registers(rA, rB, rW, WE, w, clk, A, B);
wire[31:0] A;
wire[31:0] B;
Registers registers(rA, rB, **, **, **, clk, A, B);
wire A_ALU;
wire B_ALU;
wire A_MEM;
wire B_MEM;
wire bubble;
redirection redirection_0(rA, rB, rw_exe, WE_exe_alu, WE_exe_alu, WE_exe_mem, rw_mem, WE_rw,
A_ALU, B_ALU, A_MEM, B_MEM, bubble); // 通道名

wire [3:0]redirection_ctrl;
assign redirection_ctrl = {{B_MEM},{B_ALU}, {A_MEM}, {A_ALU}};
wire [31:0] A_EXE;
wire [31:0] B_EXE;
wire [31:0] pc_4_EXE;
ID_EX id_ex(pc_4_ID, instruction_ID, A, B, redirect_ctrl, go, clear_one, clear_two, clk,
pc_4_EXE, A_EXE, B_EXE);
// go clear_one clear_two 
////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////EXE Area///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

endmodule
