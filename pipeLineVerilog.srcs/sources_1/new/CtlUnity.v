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


module CtlUnity(op, func, judge_blez, ID_ALU_op, ID_ext_u, ID_alu_src, ID_s_i, ID_reg_dst, ID_reg_write, ID_mem_write, ID_memtoReg, ID_Beq, ID_Bne, ID_J, ID_Jal, ID_Jr, ID_Syscall, ID_Lb, ID_Blez);
input [5:0] op, func;
input [4:0] judge_blez;
output [3:0]ID_ALU_op;
output ID_ext_u, ID_alu_src, ID_s_i, ID_reg_dst, ID_reg_write, ID_mem_write, ID_memtoReg, ID_Beq, ID_Bne, ID_J, ID_Jal, ID_Jr, ID_Syscall, ID_Lb, ID_Blez;
wire Add, Addi, Addiu, Addu, And, Andi, Sll, Sra, Srl, Sub, Or, Ori, Nor, Lw, Sw, Beq, Bne, Slt,  Slti, Sltu, J, Jal, Jr, Syscall, Xor, Sltiu, Lb, Blez;

decoder dcr (op, func, judge_blez, Add, Addi, Addiu, Addu, And, Andi, Sll, Sra, Srl, Sub, Or, Ori, Nor, Lw, Sw, Beq, Bne, Slt,  Slti, Sltu, J, Jal, Jr, Syscall, Xor, Sltiu, Lb, Blez);

assign ID_ALU_op[3] = (Nor | Slt | Slti | Sltu | Or | Ori | Blez);
assign ID_ALU_op[2] = (Add | Lw | Addi | Sw | Addiu | Addu | And | Andi | Sltu | Sub | Lb);
assign ID_ALU_op[1] = (Nor | Slt | And | Slti | Andi | Srl | Sub | Blez);
assign ID_ALU_op[0] = (Add | Lw | Addi | Sw | Addiu | Addu | Slt | And | Slti | Andi | Sra | Blez | Lb);
assign ID_ext_u     = (Andi | Ori);
assign ID_alu_src   = (Addiu | Sll | Srl | Lw | Addi | Sw | Slti | Andi | Sra | Ori | Lb);
assign ID_s_i       = (Srl | Sra | Sll);
assign ID_reg_dst   = (Addu | Or | Sub | Srl | Add | Nor | Slt | And | Sltu | Sll | Sra | Jr);
assign ID_reg_write = (Add | Addi | Addiu | Addu | And | Andi | Sll | Sra | Srl | Sub | Or | Ori | Nor | Lw | Slt |  Slti | Sltu | Jal | Jr | Lb);
assign ID_mem_write = (Sw);
assign ID_memtoReg  = (Lw | Lb);
assign ID_Beq       = (Beq);
assign ID_Bne       = (Bne);
assign ID_J         = (J);
assign ID_Jal       = (Jal);
assign ID_Jr        = (Jr);
assign ID_Syscall   = (Syscall);
assign ID_Lb        = (Lb);
assign ID_Blez      = (Blez);

endmodule
