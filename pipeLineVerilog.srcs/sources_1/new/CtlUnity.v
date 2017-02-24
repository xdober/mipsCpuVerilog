`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/22 23:46:31
// Design Name:
// Module Name: CtlUnity
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


module CtlUnity(op, func, judge_blez, ID_ALU_op, ID_ext_u, ID_alu_src, ID_s_i, ID_reg_dst, ID_reg_write, ID_mem_write, ID_memtoReg, ID_Beq, ID_Bne, ID_J, ID_Jal, ID_Jr, ID_Syscall, ID_Lb, ID_Blez, reset);
input [5:0] op, func;
input [4:0] judge_blez;
input reset;
output [3:0]ID_ALU_op;
output ID_ext_u, ID_alu_src, ID_s_i, ID_reg_dst, ID_reg_write, ID_mem_write, ID_memtoReg, ID_Beq, ID_Bne, ID_J, ID_Jal, ID_Jr, ID_Syscall, ID_Lb, ID_Blez;
wire Add, Addi, Addiu, Addu, And, Andi, Sll, Sra, Srl, Sub, Or, Ori, Nor, Lw, Sw, Beq, Bne, Slt,  Slti, Sltu, J, Jal, Jr, Syscall, Xor, Sltiu, Lb, Blez;

//µ÷ÓÃdecoderÄ£¿é
decoder dcr (op, func, judge_blez, Add, Addi, Addiu, Addu, And, Andi, Sll, Sra, Srl, Sub, Or, Ori, Nor, Lw, Sw, Beq, Bne, Slt,  Slti, Sltu, J, Jal, Jr, Syscall, Xor, Sltiu, Lb, Blez, reset);

assign ID_Alu_op[3] = (!reset) & (Nor | Slt | Slti | Sltu | Or | Ori | Blez);
assign ID_Alu_op[2] = (!reset) & (Add | Lw | Addi | Sw | Addiu | Addu | And | Andi | Sltu | Sub | Lb);
assign ID_Alu_op[1] = (!reset) & (Nor | Slt | And | Slti | Andi | Sri | Sub | Blez);
assign ID_Alu_op[0] = (!reset) & (Add | Lw | Addi | Sw | Addiu | Addu | Slt | And | Slti | Andi | Sra | Blez | Lb);
assign ID_ext_u     = (!reset) & (Andi | Ori);
assign ID_alu_src   = (!reset) & (Addiu | Sll | Srl | Lw | Addi | Sw | Slti | Andi | Sra | Ori | Lb);
assign ID_s_i       = (!reset) & (Srl | Sra | Sll);
assign ID_reg_dst   = (!reset) & (Addu | Or | Sub | Srl | Add | Nor | Slt | And | Sltu | Sll | Sra | Jr);
assign ID_reg_write = (!reset) & (Add | Addi | Addiu | Addu | And | Andi | Sll | Sra | Srl | Sub | Or | Ori | Nor | Lw | Sw | Slt |  Slti | Sltu | Jal | Jr | Lb);
assign ID_mem_write = (!reset) & (Sw);
assign ID_memtoReg  = (!reset) & (Lw | Lb);
assign ID_Beq       = (!reset) & (Beq);
assign ID_Bne       = (!reset) & (Bne);
assign ID_J         = (!reset) & (J);
assign ID_Jal       = (!reset) & (Jal);
assign ID_Jr        = (!reset) & (Jr);
assign ID_Syscall   = (!reset) & (Syscall);
assign ID_Lb        = (!reset) & (Lb);
assign ID_Blez      = (!reset) & (Blez);

endmodule
