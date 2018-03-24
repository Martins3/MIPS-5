module data_route(
    input clk1, 
    input [5:0]ram_addr_dispaly,
    input rst, 
    input frequency, 
    input[2:0] display, 
    
    output [7:0] AN, 
    output [7:0] SEG
    );


//////////////////////////////Common Operation//////////////////////////////////
    // frequency exchange !
    wire clk; 
    frequency_switch frequency_switch_0(clk1, clk, frequency);
    // 用于展示 ram
    wire [31:0] ram_display;
   
////////////////////////////////////////////////////////////////////////////////

/////////////////////Declaration////////////////////////////////////////////////
    wire [11:0] npc;
    wire ctrl_clash;
    wire [31:0] w_wb;
    wire [31:0] A_wb;
    wire [31:0] rw_wb;
    wire WE_wb;
    
    wire [31:0] B;
    wire [31:0] alu_out;
    wire WE_exe_alu;
    wire WE_exe_mem;
    wire WE_mem;
    wire [1:0] rw_exe;
    wire [4:0] rw_mem;
    
    wire bubble;
    wire stop_g;
    wire A_mem;
    wire B_mem;
    
     // when stop or halt, freeze all the buffer
     wire go;
     wire stop;
     wire halt;
     assign go = stop && halt;

////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////IF Area////////////////////////////////////////
    // pc 
    wire [11:0]pc;
    
    wire [11:0] pc_in;
    
    assign stop = 1'b1;
    wire pc_enable = halt && stop && (!bubble);
    program_counter p_c_0(pc_in, clk, rst, pc_enable, pc);
    wire [9:0]addr;
    wire [11:0] pc_4;
    assign addr = pc[11:2];
    assign pc_4 = pc + 4;
    // IM
    wire [31:0] instruction;
    IM im(addr, instruction);
    // ctrl
   
    wire n_ctrl_clash;
    MUX_2#12 mux_2_123(n_ctrl_clash, npc, pc_4, pc_in, 0);
////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////id Area////////////////////////////////////////
    wire [11:0] pc_4_id;
    wire [31:0] instruction_id;
    wire n_bubble; 
    IF_ID if_id(pc_4, instruction, ctrl_clash, go, n_bubble, clk, pc_4_id, instruction_id);

    wire [1:0]rA_t;
    RA_ctrl r_c_0_0(instruction_id, rA_t);

    wire[4:0] rA;
    wire[4:0] rB;
    read_reg_ctrl read_reg_ctrl_0(instruction_id, rA_t, rA, rB);
    // Registers registers(rA, rB, rW, WE, w, clk, A, B);
    wire[31:0] A_ori;
    wire[31:0] B_ori;
    Registers registers(rA, rB, rw_wb, WE_wb, w_wb, clk, A_ori, B_ori);
    wire A_ALU;
    wire B_ALU;

   
    redirection redirection_0(rA, rB, rw_exe, WE_exe_alu, WE_exe_mem, rw_mem, WE_mem,
    A_ALU, B_ALU, A_mem, B_mem, bubble); // 通道名
    assign bubble = !bubble;

    wire [3:0]redirection_ctrl_id;
    assign redirection_ctrl_id = {{B_mem},{B_ALU}, {A_mem}, {A_ALU}};
////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////exe Area///////////////////////////////////////
    wire [31:0] A_exe;
    wire [31:0] B_exe;
    wire [31:0] instruction_exe;
    wire [31:0] pc_4_exe;
    wire [3:0] redirection_ctrl_exe;
    ID_EXE id_ex(pc_4_id, instruction_id, A_ori, B_ori, redirection_ctrl_id, go, bubble, ctrl_clash, clk,
    pc_4_exe, instruction_exe, A_exe, B_exe, redirection_ctrl_exe);
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
    wire RAM_STO_exe;
    wire RAM_LOAD_exe;
    wire half_word_exe;
    wire branch;
    wire unbranch;
    wire syscall_t_exe;
    controller controller_0(instruction_exe, 
    rW_t_exe, WE_exe, w_exe, Y_t, alu_s, PC_MUX_2, PC_MUX_3, blez, beq, bne, RAM_STO_exe, RAM_LOAD_exe, half_word_exe, branch, unbranch, syscall_t_exe);


    wire [14:0] ctrl_msg;
    assign ctrl_msg = {{RAM_LOAD_exe}, {rW_t_exe}, {WE_exe}, {syscall_t_exe}, {4'b0000}, {RAM_STO_exe}, {half_word_exe}, {2'b00}};

    wire [31:0] Y;
    Y_ctrl y_ctrl(instruction_exe, B, Y_t, Y);
    
    wire [31:0] A;
    redirection_handler r_h_0( A_ori, B_ori, alu_out, w_wb, redirection_ctrl_exe, 
    A, B);
    
    wire [31:0] alu_exe;
    wire [31:0] useless_0;
    wire useless_1;
    wire useless_2;
    wire useless_3;
    ALU alu_0(A, Y, alu_s, alu_exe ,useless_0, useless_1,useless_2, useless_3);

   
    wire write_alu;
    MUX_4#1 mux_4_0(w_exe, 1'b1, 1'b1, 1'b0, 1'b0, write_alu, 1'b0);
    assign WE_exe_alu = (WE_exe & write_alu);
    assign WE_exe_mem = (WE_exe & !write_alu);

    
    write_reg_ctrl write_reg_ctrl_0(rW_t_exe, instruction_exe, rw_exe);

    wire [31:0] pc_4_exe_32;
    wire [31:0] merge_alu;
    assign pc_4_exe_32 = {{20{1'b0}}, pc_4_exe};
    MUX_4 #32 mux_4_1(w_exe, alu_exe, pc_4_exe_32, 32'h0000_0000, alu_exe, merge_alu, 32'h0000_0000);

   


    wire condi_suc;
    condi_jump c_j_0(A, B, blez, beq, bne, condi_suc);

    wire strong_halt;
    assign strong_halt = stop_g & halt;
    wire [31:0]total_cycles;
    wire [31:0]uncondi_num;
    wire [31:0]condi_num;
    wire [31:0]condi_suc_num;
    wire [31:0]SyscallOut;
   
    statistic statistic_0(A, B, clk, rst, syscall_t_exe, condi_suc, unbranch, branch, strong_halt,
    total_cycles, uncondi_num, condi_num, condi_suc_num, SyscallOut,
    halt);

    npc_generator np_0(instruction_exe, A, pc_4_exe, condi_suc, PC_MUX_2, PC_MUX_3,
    npc);
    assign n_ctrl_clash = (npc == pc_4_exe);
    assign ctrl_clash = !n_ctrl_clash;
////////////////////////////////////////////////////////////////////////////////


///////////////////////////////MEM Area/////////////////////////////////////////
    wire [31:0] instruction_mem;
    wire [14:0] ctrl_msg_mem;
    EXE_MEM exe_mem_0(instruction_exe, ctrl_msg, merge_alu, A, B, 
        go, 1'b1, clk, 
        instruction_mem, ctrl_msg_mem, alu_out, A_mem, B_mem);

    wire half_word;
    wire RAM_STO;
    wire syscall_mem;
    wire[1:0] w_mem;
    wire[1:0] rW_t;
    wire RAM_LOAD;
    assign half_word = ctrl_msg_mem[2];
    assign RAM_STO = ctrl_msg[3];
    assign syscall_mem = ctrl_msg_mem[8];
    assign WE_mem = ctrl_msg_mem[9];
    assign w_mem = ctrl_msg_mem[11:10];
    assign rW_t = ctrl_msg_mem[13:12];
    assign RAM_LOAD = ctrl_msg_mem[14];


    
    write_reg_ctrl w_r_c_0(rW_t, instruction_mem, rw_mem);

    wire byte_choose;
    wire [5:0] ram_addr;
    assign byte_choose = alu_out[0];
    assign ram_addr = alu_out[6:1];
    wire [31:0] ram_word;
    DM dm_0(ram_addr, ram_addr_dispaly, alu_out, 2'b11, rst, clk, ram_word, ram_display);

    wire [31:0] ram_word_se;
    word_ctrl w_c_0(byte_choose, half_word, ram_word, ram_word_se);

    wire [31:0] mem;
    MUX_4 #32 mux_1_1(w_mem, alu_out, alu_out, 32'h0000_0000, ram_word_se, mem, 32'h0000_0000);

////////////////////////////////////////////////////////////////////////////////

///////////////////////////////WB Area//////////////////////////////////////////
    wire syscall_wb;
    MEM_WB mem_out_0(syscall_mem, WE_mem, rw_mem, A_mem, w_mem, 
    go, 1'b1, clk, 
    syscall_wb, WE_wb, rw_wb, A_wb, w_wb);

    
    
    assign halt = !((A_wb == 32'ha) && syscall_wb);
    assign stop_g = !((A_wb == 32'h32) && syscall_wb);
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////Show Area///////////////////////////////////////
    Data_Choose show_data( display, ram_display, total_cycles, condi_num, uncondi_num,
    condi_suc_num, SyscallOut, pc, clk1, 
    AN, SEG);
////////////////////////////////////////////////////////////////////////////////
endmodule
