
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

    // ctrl
    wire [11:0] new_pc；
    MUX_2#12 mux_2_123(n_ctrl_clash, npc, pc_4, new_pc, 0);
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
    redirection redirection_0(rA, rB, rw_exe, WE_exe_alu, WE_exe_mem, rw_mem, WE_rw,
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
    wire [1:0]rW_t_exe;
    wire WE_exe;
    wire [1:0]w_exe; // choose which word to wirte
    wire [1:0]Y_t;
    wire [3:0]alu_s;
    wire PC_MUX_2;
    wire PC_MUX_3;
    wire blez;
    wire beq;
    wire bne;
    wire syscall_t_exe;
    wire RAM_STO_exe;
    wire RAM_LOAD_exe;
    wire half_word_exe;
    wire branch;
    wire unbranch;
    wire syscall_t_exe;
    controller controller_0(instruction_EXE, 
    rW_t_exe, WE_exe, w_exe, Y_t, alu_s PC_MUX_2, PC_MUX_3, blez, beq, bne, RAM_STO_exe, RAM_LOAD_exe, half_word_exe, branch, unbranch, syscall_t_exe);


    wire [14:0] ctrl_msg;
    assign ctrl_msg = {{RAM_LOAD_exe}, {rW_t_exe}, {WE_exe}, {syscall_t_exe}, {4'b0000}, {RAM_STO_exe}, {hald_word_exe}, {2'b00}};

    wire [31:0] Y;
    Y_ctrl y_ctrl(instruction_EXE, B, Y_t, Y);

    wire [31:0] alu_exe;
    wire [31:0] useless_0;
    wire useless_1;
    wire useless_2;
    wire useless_3;
    module ALU(X, Y, alu_s, alu_exe ,useless_0, useless_1,useless_2, useless_3);

    wire WE_exe_alu;
    wire WE_exe_mem;
    wire write_alu;
    MUX_4#1 mux_4_0(w_exe, 1'b1, 1'b1, 1'b0, 1'b0, write_alu, 1'b0);
    assign WE_exe_alu = (WE_exe & write_alu);
    assign WE_exe_mem = (WE_exe & !write_alu);

    wire [1:0] rw_exe;
    write_reg_ctrl write_reg_ctrl_0(rW_t_exe, instruction_EXE, rw_exe);

    wire [31:0] pc_4_EXE_32;
    wire [31:0] merge_alu;
    assign pc_4_EXE_32 = {{20{1'b0}}, pc_4_EXE};
    MUX_4 #32 mux_4_1(w_exe, alu_exe, pc_4_EXE_32, 32'h0000_0000, alu_exe, merge_alu, 32'h0000_0000);

    wire [31:0] A;
    wire [31:0] B;
    redirection_handler r_h_0( A_ori, B_ori, alu_out, mem_out,redirection_ctrl, 
    A, B);


    wire condi_suc;
    condi_jump c_j_0(A, B, blez, beq, bne, condi_suc);

    wire strong_halt;
    assign strong_halt = stop & halt;
    wire [31:0]total_cycles;
    wire [31:0]uncondi_num;
    wire [31:0]condi_num;
    wire [31:0]condi_suc_num;
    wire [31:0]SyscallOut;
    wire halt;
    statistic statistic_0(A, B, clk, rst, syscall_t_exe, condi_suc, unbranch, branch, strong_halt,
    total_cycles, uncondi_num, condi_num, condi_suc_num, SyscallOut,
    halt);

    wire [11:0] npc;
    wire n_ctrl_clash;
    wire ctrl_clash;
    npc_generator np_0(instruction_EXE, A, pc_4_EXE, condi_suc, PC_MUX_2, PC_MUX_3,
    npc);
    assign n_ctrl_clash = (npc == pc_4_EXE);
    assign ctrl_clash = !n_ctrl_clash;
////////////////////////////////////////////////////////////////////////////////


///////////////////////////////MEM Area/////////////////////////////////////////
wire [31:0] instruction_MEM;
wire [14:0] ctrl_msg_MEM;
wire [31:0] alu_out;
wire [31:0] A_MEM;
wire [31:0] B_MEM;
EXE_MEM exe_mem_0( instruction, ctrl_msg, alu, A, B, 
    go, clear, clk, 
    instruction_MEM, ctrl_msg_MEM, alu_out, A_MEM, B_MEM);

wire half_word;
wire RAM_STO;
wire syscall_mem;// 
wire WE_mem;
wire[1:0] w_mem;
wire[1:0] rW_t;
wire RAM_LOAD;
assign half_word = ctrl_msg_MEM[2];
assign RAM_STO = ctrl_msg[3];
assign syscall_mem = ctrl_msg_MEM[8];
assign WE_mem = ctrl_msg_MEM[9];
assign w_mem = ctrl_msg_MEM[11:10];
assign rW_t = ctrl_msg_MEM[13:12];
assign RAM_LOAD = ctrl_msg_MEM[14];



// word_ctrl_t

// RW

////////////////////////////////////////////////////////////////////////////////

///////////////////////////////WB Area////////////////////////////////////////
endmodule
