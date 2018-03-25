`timescale 1ns / 1ps

// 正确的初始化的数值
// 注愝一个问题， 表格中间淘汰坪会由于新加入的表格， 所以valid 坪会在初始化的时候坘戝0
// 使用 pc_4 作为查询的


// maybe may lead some probelm

module BHT(
    input clk,

    input [11:0] insert_ins_addr,
    input [11:0] insert_ins_next_addr,
    input is_branch,
    input is_suc,

	input [11:0] query_ins_addr,
    output [11:0] prediect_addr,
    output prediect_jump
	);


    reg valid [0:7];
	reg [31:0] addr [0:7];
    reg [31:0] next_addr[0:7];
    reg [1:0] history[0:7];

    reg [2:0] fifo;

    
    ////////////////////////////////query///////////////////////////////////////
        wire jump_0;
        assign jump_0 = (query_ins_addr == addr[0]) && valid[0] && (history[0] == 2'b01 || history[0] == 2'b11);

        wire jump_1;
        assign jump_1 = (query_ins_addr == addr[1]) && valid[1] && (history[1] == 2'b01 || history[1] == 2'b11);

        wire jump_2;
        assign jump_2 = (query_ins_addr == addr[2]) && valid[2] && (history[2] == 2'b01 || history[2] == 2'b11);

        wire jump_3;
        assign jump_3 = (query_ins_addr == addr[3]) && valid[3] && (history[3] == 2'b01 || history[3] == 2'b11);

        wire jump_4;
        assign jump_4 = (query_ins_addr == addr[4]) && valid[4] && (history[4] == 2'b01 || history[4] == 2'b11);

        wire jump_5;
        assign jump_5 = (query_ins_addr == addr[5]) && valid[5] && (history[5] == 2'b01 || history[5] == 2'b11);

        wire jump_6;
        assign jump_6 = (query_ins_addr == addr[6]) && valid[6] && (history[6] == 2'b01 || history[6] == 2'b11);

        wire jump_7;
        assign jump_7 = (query_ins_addr == addr[7]) && valid[7] && (history[7] == 2'b01 || history[7] == 2'b11);

        assign prediect_jump = jump_0 || jump_1 ||  jump_2 || jump_3 || jump_4 || jump_5 || jump_6 || jump_7;
        assign  prediect_addr = jump_0 ? next_addr[0] : 12'bz,
                prediect_addr = jump_1 ? next_addr[1] : 12'bz,
                prediect_addr = jump_2 ? next_addr[2] : 12'bz,
                prediect_addr = jump_3 ? next_addr[3] : 12'bz,
                prediect_addr = jump_4 ? next_addr[4] : 12'bz,
                prediect_addr = jump_5 ? next_addr[5] : 12'bz,
                prediect_addr = jump_6 ? next_addr[6] : 12'bz,
                prediect_addr = jump_7 ? next_addr[7] : 12'bz;
    ////////////////////////////////////////////////////////////////////////////

    //////////////////////////////// insert ////////////////////////////////////
        /////////////////////////////////0//////////////////////////////////////
            wire insert_hit_0;
            wire insert_suc_0;
            wire insert_fail_0;
            assign insert_hit_0 = is_branch && (insert_ins_addr == addr[0]) && valid[0];
            assign insert_suc_0 = insert_hit_0 && is_suc;
            assign insert_fail_0 = insert_hit_0 && !is_suc;
        ////////////////////////////////////////////////////////////////////////

        /////////////////////////////////1//////////////////////////////////////
            wire insert_hit_1;
            wire insert_suc_1;
            wire insert_fail_1;
            assign insert_hit_1 = is_branch && (insert_ins_addr == addr[1]) && valid[1];
            assign insert_suc_1 = insert_hit_1 && is_suc;
            assign insert_fail_1 = insert_hit_1 && !is_suc;
        ////////////////////////////////////////////////////////////////////////

        /////////////////////////////////2//////////////////////////////////////
            wire insert_hit_2;
            wire insert_suc_2;
            wire insert_fail_2;
            assign insert_hit_2 = is_branch && (insert_ins_addr == addr[2]) && valid[2];
            assign insert_suc_2 = insert_hit_2 && is_suc;
            assign insert_fail_2 = insert_hit_2 && !is_suc;
        ////////////////////////////////////////////////////////////////////////

        /////////////////////////////////3//////////////////////////////////////
            wire insert_hit_3;
            wire insert_suc_3;
            wire insert_fail_3;
            assign insert_hit_3 = is_branch && (insert_ins_addr == addr[3]) && valid[3];
            assign insert_suc_3 = insert_hit_3 && is_suc;
            assign insert_fail_3 = insert_hit_3 && !is_suc;
        ////////////////////////////////////////////////////////////////////////

        /////////////////////////////////4//////////////////////////////////////
            wire insert_hit_4;
            wire insert_suc_4;
            wire insert_fail_4;
            assign insert_hit_4 = is_branch && (insert_ins_addr == addr[4]) && valid[4];
            assign insert_suc_4 = insert_hit_4 && is_suc;
            assign insert_fail_4 = insert_hit_4 && !is_suc;
        ////////////////////////////////////////////////////////////////////////

        /////////////////////////////////5//////////////////////////////////////
            wire insert_hit_5;
            wire insert_suc_5;
            wire insert_fail_5;
            assign insert_hit_5 = is_branch && (insert_ins_addr == addr[5]) && valid[5];
            assign insert_suc_5 = insert_hit_5 && is_suc;
            assign insert_fail_5 = insert_hit_5 && !is_suc;
        ////////////////////////////////////////////////////////////////////////


        /////////////////////////////////6//////////////////////////////////////
            wire insert_hit_6;
            wire insert_suc_6;
            wire insert_fail_6;
            assign insert_hit_6 = is_branch && (insert_ins_addr == addr[6]) && valid[6];
            assign insert_suc_6 = insert_hit_6 && is_suc;
            assign insert_fail_6 = insert_hit_6 && !is_suc;
        ////////////////////////////////////////////////////////////////////////

        /////////////////////////////////7//////////////////////////////////////
            wire insert_hit_7;
            wire insert_suc_7;
            wire insert_fail_7;
            assign insert_hit_7 = is_branch && (insert_ins_addr == addr[7]) && valid[7];
            assign insert_suc_7 = insert_hit_7 && is_suc;
            assign insert_fail_7 = insert_hit_7 && !is_suc;
        ////////////////////////////////////////////////////////////////////////

        wire insert_no_hit; // 没有命中 
        assign insert_no_hit = is_branch && !(insert_hit_0 || insert_hit_1 || insert_hit_2 || insert_hit_3 || insert_hit_4 || insert_hit_5 || insert_hit_6 || insert_hit_7);
    ////////////////////////////////////////////////////////////////////////////


    // 修改寄存器中间的数值必须使用 reg 

	integer i;
	initial begin
	    for (i=0; i<8; i=i+1) begin 
            valid[i] <= 0;
            addr[i] <= 0;
            next_addr[i] <= 0;
            history[i] <= 1;
            fifo[i] <= 0;
        end
	end


	always @(posedge clk) begin
        if(insert_no_hit) begin
            fifo <= fifo + 1;
            addr[fifo] <= insert_ins_addr; 
            next_addr[fifo] <= insert_ins_next_addr;
            valid[fifo] <= 1; 
        end

        //////////////////////////////insert//////////////////////////////////////
            //////////////////////////insert 0//////////////////////////////////////
                if(insert_suc_0) begin
                    if(history[0] != 2'b11) begin
                        history[0] = history[0] + 1;
                    end
                end

                if(insert_fail_0) begin
                    if(history[0] != 2'b00) begin
                        history[0] = history[0] - 1;
                    end
                end
            ////////////////////////////////////////////////////////////////////////

            //////////////////////////insert 1//////////////////////////////////////
                if(insert_suc_1) begin
                    if(history[1] != 2'b11) begin
                        history[1] = history[1] + 1;
                    end
                end

                if(insert_fail_1) begin
                    if(history[1] != 2'b00) begin
                        history[1] = history[1] - 1;
                    end
                end
            ////////////////////////////////////////////////////////////////////////

            //////////////////////////insert 3//////////////////////////////////////
                if(insert_suc_3) begin
                    if(history[3] != 2'b11) begin
                        history[3] = history[3] + 1;
                    end
                end

                if(insert_fail_3) begin
                    if(history[3] != 2'b00) begin
                        history[3] = history[3] - 1;
                    end
                end
            ////////////////////////////////////////////////////////////////////////


            //////////////////////////insert 4//////////////////////////////////////
                if(insert_suc_4) begin
                    if(history[4] != 2'b11) begin
                        history[4] = history[4] + 1;
                    end
                end

                if(insert_fail_4) begin
                    if(history[4] != 2'b00) begin
                        history[4] = history[4] - 1;
                    end
                end
            ////////////////////////////////////////////////////////////////////////

            //////////////////////////insert 5//////////////////////////////////////
                if(insert_suc_5) begin
                    if(history[5] != 2'b11) begin
                        history[5] = history[5] + 1;
                    end
                end

                if(insert_fail_5) begin
                    if(history[5] != 2'b00) begin
                        history[5] = history[5] - 1;
                    end
                end
            ////////////////////////////////////////////////////////////////////////

            //////////////////////////insert 6//////////////////////////////////////
                if(insert_suc_6) begin
                    if(history[6] != 2'b11) begin
                        history[6] = history[6] + 1;
                    end
                end

                if(insert_fail_6) begin
                    if(history[6] != 2'b00) begin
                        history[6] = history[6] - 1;
                    end
                end
            ////////////////////////////////////////////////////////////////////////

            //////////////////////////insert 7//////////////////////////////////////
                if(insert_suc_7) begin
                    if(history[7] != 2'b11) begin
                        history[7] = history[7] + 1;
                    end
                end

                if(insert_fail_7) begin
                    if(history[7] != 2'b00) begin
                        history[7] = history[7] - 1;
                    end
                end
            ////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////
	end



endmodule
