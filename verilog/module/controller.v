
`timescale 1ns / 1ps
module controller(
    input [31:0]instruction,

    output [1:0]rW,
    output WE,
    output [1:0]w,
    output [1:0]Y,
    output [3:0]alu_s,
    output PC_MUX_2,
    output PC_MUX_3,
    output blez,
    output beq,
    output bne,
    output RAM_STO,
    output RAM_LOAD,
    output hald_word,
    output branch,
    output unbranch,
    output syscall
    );

        //　生成的　funct  op  和　is_R
        wire [5:0]op;
        wire [5:0]funct;
        wire is_R;
    
        assign op = instruction[31:26];
        assign funct = instruction[5:0];
        assign is_R = !(op[0] | op[1] | op[2] | op[3] | op[4] | op[5]); 


        assign rW = is_R ? 2'b00 : 2'bz,
               rW = (!is_R && op == 6'b000011) ? 2'b01 : 2'bz,
               rW = (!is_R && ( (op == 6'b001000 || op == 6'b001001 || op == 6'b001100 || op == 6'b001101 || op == 6'b001010 || op == 6'b100001 || op == 6'b100011))) ? 2'b11:2'bz; 



        assign WE = (is_R && (funct != 6'b001000 && funct != 6'b001100)) || 
                    (!is_R && ( (op == 6'b001000 || op == 6'b001001 || op == 6'b001100 || op == 6'b001101 || op == 6'b001010 || op == 6'b100001 || op == 6'b100011))) ||
                    (!is_R && op == 6'b000011);

        assign  w = is_R ? 2'b00 : 2'bz,
                w = (!is_R && (op == 6'b000011)) ? 2'b01 : 2'bz ,
                w = (!is_R && (op == 6'b100001 || op == 6'b100011)) ? 2'b11:2'bz;
        
        assign Y =  (is_R && ( funct == 6'b100000 || funct == 6'b100001 || funct == 6'b100100 || funct == 6'b100010 || funct == 6'b100101 || funct == 6'b100111 || funct == 6'b101010 || funct == 6'b101011 || funct == 6'b000110 || funct == 6'b000111)) ? 2'b00: 2'bz,
               Y = (is_R && (funct == 6'b000000 || funct == 6'b000011 || funct == 6'b000010)) ? 2'b01 : 2'bz,
               Y = (!is_R && (op == 6'b000110 || op == 6'b000100 || op == 6'b000101 )) ? 2'b00 : 2'bz,
               Y = (!is_R && ( op == 001000 || op == 001001 || op == 001100 || op == 001101 || op == 001010 || op == 100001 || op == 100011 || op == 101011)) ? 2'b11:2'bz;

        
        
        

        assign
                // R
                alu_s = (is_R && funct == 6'b100000) ? 4'b0101: 4'bz,
                alu_s = (is_R && funct == 6'b100001) ? 4'b0101: 4'bz,
                alu_s = (is_R && funct == 6'b100100) ? 4'b0111: 4'bz,
                alu_s = (is_R && funct == 6'b100010) ? 4'b0110: 4'bz,
                alu_s = (is_R && funct == 6'b100101) ? 4'b1000: 4'bz,
                alu_s = (is_R && funct == 6'b100111) ? 4'b1010: 4'bz,
                alu_s = (is_R && funct == 6'b101010) ? 4'b1011: 4'bz,
                alu_s = (is_R && funct == 6'b101011) ? 4'b1011: 4'bz,

                alu_s = (is_R && funct == 6'b000110) ? 4'b0010: 4'bz,
                alu_s = (is_R && funct == 6'b000111) ? 4'b0001: 4'bz,

                alu_s = (is_R && funct == 6'b000000) ? 4'b0000: 4'bz,
                alu_s = (is_R && funct == 6'b000011) ? 4'b0010: 4'bz,
                alu_s = (is_R && funct == 6'b000010) ? 4'b0100: 4'bz,

                // not R
                alu_s = (!is_R && op == 6'b001000) ? 4'b0101: 4'bz,
                alu_s = (!is_R && op == 6'b001001) ? 4'b0101: 4'bz,
                alu_s = (!is_R && op == 6'b001100) ? 4'b0111: 4'bz,
                alu_s = (!is_R && op == 6'b001101) ? 4'b1000: 4'bz,
                alu_s = (!is_R && op == 6'b001010) ? 4'b1011: 4'bz,

                alu_s = (!is_R && op == 6'b100001) ? 4'b0101: 4'bz,
                alu_s = (!is_R && op == 6'b100011) ? 4'b0101: 4'bz,
                alu_s = (!is_R && op == 6'b101011) ? 4'b0101: 4'bz;

        assign PC_MUX_2 = !(!is_R && (op == 6'b000010 || op == 6'b000011));

        assign PC_MUX_3 = (!is_R && (op == 6'b001000));

        assign blez = (!is_R && op == 6'b000110);

        assign beq = (!is_R && op == 6'b000100);

        assign bne = (!is_R && op == 6'b000101);

        assign RAM_STO = (!is_R && op == 6'b100001);

        assign RAM_LOAD = (!is_R && op == 6'b100001) || (!is_R && op == 6'b100011);

        assign hald_word = (!is_R && op == 6'b101011);
        
        assign branch = (!is_R && (op == 6'b000110 || op == 6'b000100 || op == 6'b000101));

        assign unbranch = (!is_R && (op == 6'b100001 || op == 6'b100011 || op == 6'b101011));
        
        assign syscall = (is_R && funct == 6'b001100);
endmodule

