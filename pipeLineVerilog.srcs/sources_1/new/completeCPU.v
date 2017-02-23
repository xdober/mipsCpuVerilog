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

//IF stage
assign PCFromJump = (J || Jal) ? JumpAddr : PCplus4_IF;
assign PCFromJr = (Jr) ? JrAddr : PCFromJump;
assign PCFromBranch = (B_clr_IF_ID) ? BranchResult : PCFromJr;
register32 regPC(PCFromBranch, en_PC, clk, PC_IF, 0);
assign PCplus4_IF = (4 + PC_IF);
ROM iROM(PC_IF[11:2], ins_IF);

//IF->ID
IF_ID if_id(IF_ins, IF_PCplus4, en_ID, clk, clr_ID, ID_ins, ID_PCplus4);
assign clr_ID = (J_Jr_Jal_EX | B_clr_IF_ID);

//ID
CtlUnity ctl(ID_ins[31:26], ID_ins[5:0], ID_ALU_op, ID_ext_u, ID_alu_src, ID_s_i, ID_reg_dst, ID_reg_write, ID_mem_write, ID_memtoReg, ID_Beq, ID_Bne, ID_J, ID_Jal, ID_Jr, ID_Syscall, reset);
assign ID_rt = (ID_ins[20:16]);
assign ID_rs = (ID_ins[25:21]);
assign ID_rd = (ID_ins[15:11]);
assign R1__ = (ID_s_i) ? ID_rt : ID_rs;
assign R2__ = (ID_rt);


endmodule
