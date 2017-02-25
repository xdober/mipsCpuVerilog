`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/22 21:49:42
// Design Name:
// Module Name: decoder
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module decoder(op, func, judge_blez, Add, Addi, Addiu, Addu, And, Andi, Sll, Sra, Srl, Sub, Or, Ori, Nor, Lw, Sw, Beq, Bne, Slt,  Slti, Sltu, J, Jal, Jr, Syscall, Xor, Sltiu, Lb, Blez);
input [5:0] op, func;
input [4:0] judge_blez;
output Add, Addi, Addiu, Addu, And, Andi, Sll, Sra, Srl, Sub, Or, Ori, Nor, Lw, Sw, Beq, Bne, Slt,  Slti, Sltu, J, Jal, Jr, Syscall, Xor, Sltiu, Lb, Blez;

assign Add     = ((op==0) && (func==6'b100000)) ?1 : 0;
assign Addi    = (op==6'b001000) ? 1 : 0;
assign Addiu   = (op==6'b001001) ? 1 : 0;
assign Addu    = (op==0 && func==6'b100001) ? 1 : 0;
assign And     = (op==0 && func==6'b100100) ? 1 : 0;
assign Andi    = (op==6'b001100) ? 1 : 0;
assign Sll     = (op==0 && func==0) ? 1 : 0;
assign Sra     = (op==0 && func==6'b000011) ? 1 : 0;
assign Srl     = (op==0 && func==6'b000010) ? 1 : 0;
assign Sub     = (op==0 && func==6'b100010) ? 1 : 0;
assign Or      = (op==0 && func==6'b100101) ? 1 : 0;
assign Ori     = (op==6'b001101) ? 1 : 0;
assign Nor     = (op==0 && func==6'b100111) ? 1 : 0;
assign Lw      = (op==6'b100011) ? 1 : 0;
assign Sw      = (op==6'b101011) ? 1 : 0;
assign Beq     = (op==6'b000100) ? 1 : 0;
assign Bne     = (op==6'b000101) ? 1 : 0;
assign Slt     = (op==0 && func==6'b101010) ? 1 : 0;
assign  Slti   = (op==6'b001010) ? 1 : 0;
assign Sltu    = (op==0 && func==6'b101011) ? 1 : 0;
assign J       = (op==6'b000010) ? 1 : 0;
assign Jal     = (op==6'b000011) ? 1 : 0;
assign Jr      = (op==0 && func==6'b001000) ? 1 : 0;
assign Syscall = (op==0 && func==6'b001100) ? 1 : 0;
assign Xor     = (op==0 && func==6'b100110) ? 1 : 0;
assign Sltiu   = (op==6'b001011) ? 1 : 0;
assign Lb      = (op==0'b100000) ? 1 : 0;
assign Blez    = (op==6'b000110 && judge_blez==0) ? 1 : 0;

endmodule
