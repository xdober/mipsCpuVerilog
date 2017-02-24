`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 22:22:00
// Design Name:
// Module Name: completeCPU
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


module completeCPU(input clkin, input reset, input power);
wire [31:0] PCFromJump, PCFromJr, PCFromBranch, PC_IF, IF_PCplus4, IF_ins, ID_ins, ID_PCplus4;
wire clr_ID,en_ID, clk;
wire [3:0] ID_ALU_op;
wire ID_ext_u, ID_alu_src, ID_s_i, ID_reg_dst, ID_reg_write, ID_mem_write, ID_memtoReg, ID_Beq, ID_Bne, ID_J, ID_Jal, ID_Jr, ID_Syscall;

//IF
assign PCFromJump = (EX_j || EX_jal) ? JumpAddr : PCplus4_IF;
assign PCFromJr = (EX_jr) ? JrAddr : PCFromJump;
assign PCFromBranch = (B_clr_IF_ID) ? BranchResult : PCFromJr;
register32 regPC(PCFromBranch, en_PC, clk, PC_IF, 0);
assign PCplus4_IF = (4 + PC_IF);
ROM iROM(PC_IF[11:2], ins_IF);


//IF --> ID
IF_ID if_id(IF_ins, IF_PCplus4, en_ID, clk, clr_ID, ID_ins, ID_PCplus4);
assign clr_ID = (J_Jr_Jal_EX | B_clr_IF_ID);


//ID
CtlUnity ctl(ID_ins[31:26], ID_ins[5:0], ID_ins[20:16], ID_ALU_op, ID_ext_u, ID_alu_src, ID_s_i, ID_reg_dst, ID_reg_write, ID_mem_write, ID_memtoReg, ID_Beq, ID_Bne, ID_J, ID_Jal, ID_Jr, ID_Syscall, ID_Lb, ID_Blez, reset);
assign ID_rt = (ID_ins[20:16]);
assign ID_rs = (ID_ins[25:21]);
assign ID_rd = (ID_ins[15:11]);

assign ID_R1_ = (ID_s_i) ? ID_rt : ID_rs;
assign ID_R2_ = (ID_rt);

assign ID_imme16 = (ID_ins[15:0]);
assign ID_JumpAddr = ({ID_PCplus4[31:28],ID_ins[27:2],2'b00});
assign ID_imme5 = (ID_ins[10:6]);
signed_16to32 sgn16_1(ID_imme16, ID_imme16_EX_S);
unsigned_16to32 usgn16_1(ID_imme16, ID_imme16_EX_U);
unsigned_5to32 usn5_1(ID_imme5, ID_imme5_EX_U);
assign ID_gotoLableResult = (ID_PCplus4 + (ID_imme16_EX_S << 2));
assign ID_dstResult = (ID_reg_dst) ? ID_rd : ID_rt;
assign ID_Immediate_EX = (ID_s_i) ? ID_imme5_EX_U : (ID_ext_u ? ID_imme16_EX_U : ID_imme16_EX_S);
regfile regfile0(ID_R1_, ID_R2_, WB_RW, WB_Din, WB_WE, clk, ID_Reg1, ID_Reg2, v0Value, a0Value, s2value, raValue, reset);

//ID --> EX
ID_EX id_ex(ID_syscall, ID_jr, ID_jal, ID_j, ID_bne, ID_beq, ID_memToReg, ID_memWrite, ID_WE, ID_AluSrc, ID_AluOP, ID_Lb, ID_Blez, ID_dstResult, ID_gotoLableResult, ID_R1_, ID_R2_, ID_JumpAddr, ID_IR, ID_Reg1, ID_Reg2, ID_Immediate_EX, ID_PCplus4, clk, EX_clr, EX_syscall, EX_jr, EX_jal, EX_j, EX_bne, EX_beq, EX_memToReg, EX_memWrite, EX_WE, EX_AluSrc, EX_AluOP, EX_Lb, EX_Blez, EX_dstResult, EX_gotoLableResult, EX_R1_, EX_R2_, EX_JumpAddr, EX_IR, EX_Reg1, EX_Reg2, EX_Immediate_EX, EX_PCplus4);

//EX
assign EX_JorJRorJAL = (EX_j | EX_jal | EX_jr);
assign ALU_Xin = (Reg1_OP[1]) ? WB_Din : (Reg1_OP[0] ? MEM_AluResult : EX_Reg1);
assign JrAddr = (ALU_Xin);
assign EX_memDate = (Reg2_OP[1]) ? WB_Din : (Reg2_OP[0] ? MEM_AluResult : EX_Reg2);
assign Alu_Yin = (EX_AluSrc) ? EX_Immediate_EX : EX_memDate;
ALU alu(ALU_Xin, Alu_Yin, EX_AluOP, EX_AluResult, EX_isEqual);
assign branchNum = ((EX_bne & !EX_isEqual) | (EX_beq & EX_isEqual) | (EX_Blez & (EX_isEqual EX_AluResult[0])) );
register1 branch(branchNum, 1, !clk, B_clr_IF_ID, 0);

//EX --> MEM
EX_MEM ex_mem(EX_syscall, EX_Jal, EX_memToReg, EX_memWrite, EX_WE, EX_Lb, EX_dstResult, EX_IR, EX_AluResult, EX_memDate, EX_PCplus4, clk, MEM_syscall, MEM_Jal, MEM_memToReg, MEM_memWrite, MEM_WE, MEM_Lb, MEM_dstResult, MEM_IR, MEM_AluResult, MEM_memDate, MEM_PCplus4);

//MEM
assign memAddr = (EX_AluResult[11:2]);
RAM dRAM(memAddr, MEM_memDate, MEM_WE, clk, reset, memDout);
assign MEM_RW = (MEM_Jal) ? 16'h1f : MEM_dstResult;
assign memDataByte = (MEM_AluResult[1]) ? (MEM_AluResult[0] ? memDout[31:24] : memDout[23:16]) : (MEM_AluResult[0] ? memDout[15:8] : memDout[7:0]);
signed_8to32 byteE(memDataByte, ByteEXT);
assign MEM_Din = (MEM_Jal) ? MEM_PCplus4 : (MEM_memToReg ? (MEM_Lb ? ByteEXT : memDout) : MEM_AluResult);

//MEM --> WB
MEM_WB(MEM_syscall, MEM_Jal, MEM_WE, MEM_RW, MEM_Din, MEM_IR, MEM_PCplus4, clk, WB_syscall, WB_Jal, WB_WE, WB_RW, WB_Dout, WB_IR, WB_PCplus4);

//WB
assign WB_Din = (WB_Jal) ? WB_PCplus4 : WB_Dout;


endmodule
