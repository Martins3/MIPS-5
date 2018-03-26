`timescale 1ns / 1ps
module BHT(
    input clk,

    input [11:0] insert_ins_addr,
    input [11:0] insert_ins_next_addr,
    input is_branch,
    input is_suc,

	input [11:0] query_ins_addr,
    output [11:0] predict_addr,
    output predict_jump
	);


    reg valid [0:7];
	reg [31:0] addr [0:7];
    reg [31:0] next_addr[0:7];
    reg [1:0] history[0:7];
    reg [31:0] LRU[0:7];    


    
    ////////////////////////////////query///////////////////////////////////////
        wire jump_0;
        assign jump_0 = (query_ins_addr == addr[0]) && valid[0] && (history[0] == 2'b10 || history[0] == 2'b11);

        wire jump_1;
        assign jump_1 = (query_ins_addr == addr[1]) && valid[1] && (history[1] == 2'b10 || history[1] == 2'b11);

        wire jump_2;
        assign jump_2 = (query_ins_addr == addr[2]) && valid[2] && (history[2] == 2'b10 || history[2] == 2'b11);

        wire jump_3;
        assign jump_3 = (query_ins_addr == addr[3]) && valid[3] && (history[3] == 2'b10 || history[3] == 2'b11);

        wire jump_4;
        assign jump_4 = (query_ins_addr == addr[4]) && valid[4] && (history[4] == 2'b0 || history[4] == 2'b11);

        wire jump_5;
        assign jump_5 = (query_ins_addr == addr[5]) && valid[5] && (history[5] == 2'b10 || history[5] == 2'b11);

        wire jump_6;
        assign jump_6 = (query_ins_addr == addr[6]) && valid[6] && (history[6] == 2'b10 || history[6] == 2'b11);

        wire jump_7;
        assign jump_7 = (query_ins_addr == addr[7]) && valid[7] && (history[7] == 2'b10 || history[7] == 2'b11);

        assign predict_jump = jump_0 || jump_1 ||  jump_2 || jump_3 || jump_4 || jump_5 || jump_6 || jump_7;
        assign  predict_addr = jump_0 ? next_addr[0] : 12'bz,
                predict_addr = jump_1 ? next_addr[1] : 12'bz,
                predict_addr = jump_2 ? next_addr[2] : 12'bz,
                predict_addr = jump_3 ? next_addr[3] : 12'bz,
                predict_addr = jump_4 ? next_addr[4] : 12'bz,
                predict_addr = jump_5 ? next_addr[5] : 12'bz,
                predict_addr = jump_6 ? next_addr[6] : 12'bz,
                predict_addr = jump_7 ? next_addr[7] : 12'bz;
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

    ///////////////////////////////// find max/////////////////////////////////
        // 计算出来 正确的佝置 
        wire  [2:0] i_12;
        wire  [2:0] i_34;
        wire  [2:0] i_56;
        wire  [2:0] i_78;

        wire [2:0] i_1234;
        wire [2:0] i_5678;

        wire [2:0] max_index;

        assign i_12 =  LRU[0] >= LRU[1] ? 3'b000 : 3'b001;
        assign i_34 =  LRU[2] >= LRU[3] ? 3'b010 : 3'b011;
        assign i_56 =  LRU[4] >= LRU[5] ? 3'b100 : 3'b101;
        assign i_78 =  LRU[6] >= LRU[7] ? 3'b110 : 3'b111;

        assign i_1234 =  LRU[i_12] >= LRU[i_34] ? i_12 : i_34;
        assign i_5678 =  LRU[i_56] >= LRU[i_78] ? i_56 : i_78;

        assign max_index =  LRU[i_1234] >= LRU[i_5678] ? i_1234 : i_5678;
    ////////////////////////////////////////////////////////////////////////////


    // 修改寄存器中间的数值必须使用 reg 

	integer i;
	initial begin
	    for (i=0; i<8; i=i+1) begin 
            valid[i] <= 0;
            addr[i] <= 0;
            next_addr[i] <= 0;
            history[i] <= 2'b10;
            LRU[i] <= 0;
        end
	end


	always @(posedge clk) begin
        if(insert_no_hit) begin
            // max_index : clear LRU, set addr and next addr 
            addr[max_index] <= insert_ins_addr;
            next_addr[max_index] <= insert_ins_next_addr;
            LRU[max_index] <= 0;
            valid[max_index] <= 1;
            history[max_index] <= 2'b11;
            
            // others
            if(max_index != 0) begin  LRU[0] <= LRU[0] + 1; end
            if(max_index != 1) begin  LRU[1] <= LRU[1] + 1; end
            if(max_index != 2) begin  LRU[2] <= LRU[2] + 1; end
            if(max_index != 3) begin  LRU[3] <= LRU[3] + 1; end

            if(max_index != 4) begin  LRU[4] <= LRU[4] + 1; end
            if(max_index != 5) begin  LRU[5] <= LRU[5] + 1; end
            if(max_index != 6) begin  LRU[6] <= LRU[6] + 1; end
            if(max_index != 7) begin  LRU[7] <= LRU[7] + 1; end
        end

        //////////////////////////////insert//////////////////////////////////////
            //////////////////////////insert 0//////////////////////////////////////
                if(insert_suc_0) begin
                    if(history[0] != 2'b11) begin
                        history[0] <= history[0] + 1;
                    end
                    LRU[0] <= 0; 
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= LRU[7] + 1; 
                end

                if(insert_fail_0) begin
                    if(history[0] != 2'b00) begin
                        history[0] <= history[0] - 1;
                    end
                    LRU[0] <= 0;
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= LRU[7] + 1; 
                end
            ////////////////////////////////////////////////////////////////////////

            //////////////////////////insert 1//////////////////////////////////////
                if(insert_suc_1) begin
                    if(history[1] != 2'b11) begin
                        history[1] <= history[1] + 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= 0; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= LRU[7] + 1; 
                end

                if(insert_fail_1) begin
                    if(history[1] != 2'b00) begin
                        history[1] <= history[1] - 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= 0; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= LRU[7] + 1; 
                end
            ////////////////////////////////////////////////////////////////////////


            //////////////////////////insert 2//////////////////////////////////////
                if(insert_suc_2) begin
                    if(history[2] != 2'b11) begin
                        history[2] <= history[2] + 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= 0; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= LRU[7] + 1; 
                end

                if(insert_fail_2) begin
                    if(history[2] != 2'b00) begin
                        history[2] <= history[2] - 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= 0; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= LRU[7] + 1; 
                end
            ////////////////////////////////////////////////////////////////////////

            //////////////////////////insert 3//////////////////////////////////////
                if(insert_suc_3) begin
                    if(history[3] != 2'b11) begin
                        history[3] = history[3] + 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= 0; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= LRU[7] + 1; 
                end

                if(insert_fail_3) begin
                    if(history[3] != 2'b00) begin
                        history[3] = history[3] - 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= 0; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= LRU[7] + 1; 
                end
            ////////////////////////////////////////////////////////////////////////


            //////////////////////////insert 4//////////////////////////////////////
                if(insert_suc_4) begin
                    if(history[4] != 2'b11) begin
                        history[4] = history[4] + 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= 0; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= LRU[7] + 1; 
                end

                if(insert_fail_4) begin
                    if(history[4] != 2'b00) begin
                        history[4] = history[4] - 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= 0; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= LRU[7] + 1; 
                end
            ////////////////////////////////////////////////////////////////////////

            //////////////////////////insert 5//////////////////////////////////////
                if(insert_suc_5) begin
                    if(history[5] != 2'b11) begin
                        history[5] = history[5] + 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= 0; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= LRU[7] + 1; 
                end

                if(insert_fail_5) begin
                    if(history[5] != 2'b00) begin
                        history[5] = history[5] - 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= 0; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= LRU[7] + 1; 
                end
            ////////////////////////////////////////////////////////////////////////

            //////////////////////////insert 6//////////////////////////////////////
                if(insert_suc_6) begin
                    if(history[6] != 2'b11) begin
                        history[6] = history[6] + 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= 0; 
                    LRU[7] <= LRU[7] + 1; 
                end

                if(insert_fail_6) begin
                    if(history[6] != 2'b00) begin
                        history[6] = history[6] - 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= 0; 
                    LRU[7] <= LRU[7] + 1; 
                end
            ////////////////////////////////////////////////////////////////////////

            //////////////////////////insert 7//////////////////////////////////////
                if(insert_suc_7) begin
                    if(history[7] != 2'b11) begin
                        history[7] = history[7] + 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= 0; 
                end

                if(insert_fail_7) begin
                    if(history[7] != 2'b00) begin
                        history[7] = history[7] - 1;
                    end
                    LRU[0] <= LRU[0] + 1; 
                    LRU[1] <= LRU[1] + 1; 
                    LRU[2] <= LRU[2] + 1; 
                    LRU[3] <= LRU[3] + 1; 

                    LRU[4] <= LRU[4] + 1; 
                    LRU[5] <= LRU[5] + 1; 
                    LRU[6] <= LRU[6] + 1; 
                    LRU[7] <= 0; 
                end
            ////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////
	end



endmodule
