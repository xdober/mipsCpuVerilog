`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 17:13:56
// Design Name:
// Module Name: ID_EX
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


module ID_EX(ID_syscall, ID_jr, ID_jal, ID_j, ID_bne, ID_beq, ID_memToReg, ID_memWrite, ID_WE, ID_AluSrc, ID_AluOP, ID_Lb, ID_Blez, ID_dstResult, ID_gotoLableResult, ID_R1_, ID_R2_, ID_JumpAddr, ID_IR, ID_Reg1, ID_Reg2, ID_Immediate_EX, ID_PCplus4, clk, clr, EX_syscall, EX_jr, EX_jal, EX_j, EX_bne, EX_beq, EX_memToReg, EX_memWrite, EX_WE, EX_AluSrc, EX_AluOP, EX_Lb, EX_Blez, EX_dstResult, EX_gotoLableResult, EX_R1_, EX_R2_, EX_JumpAddr, EX_IR, EX_Reg1, EX_Reg2, EX_Immediate_EX, EX_PCplus4);
input [31:0] ID_gotoLableResult, ID_JumpAddr, ID_IR, ID_Reg1, ID_Reg2, ID_Immediate_EX, ID_PCplus4;
input [4:0] ID_dstResult, ID_R1_, ID_R2_;
input [3:0] ID_AluOP;
input ID_syscall, ID_jr, ID_jal, ID_j, ID_bne, ID_beq, ID_memToReg, ID_memWrite, ID_WE, ID_Lb, ID_Blez, clk, clr, ID_AluSrc;
output reg [31:0] EX_gotoLableResult, EX_JumpAddr, EX_IR, EX_Reg1, EX_Reg2, EX_Immediate_EX, EX_PCplus4;
output reg [4:0] EX_dstResult, EX_R1_, EX_R2_;
output reg [3:0] EX_AluOP;
output reg EX_syscall, EX_jr, EX_jal, EX_j, EX_bne, EX_beq, EX_memToReg, EX_memWrite, EX_WE, EX_Lb, EX_Blez, EX_AluSrc;
always @ (posedge clk or posedge clr) begin
    if (clr) begin
        EX_syscall         = 0;
        EX_jr              = 0;
        EX_jal             = 0;
        EX_j               = 0;
        EX_bne             = 0;
        EX_beq             = 0;
        EX_memToReg        = 0;
        EX_memWrite        = 0;
        EX_WE              = 0;
        EX_AluSrc          = 0;
        EX_AluOP           = 0;
        EX_Lb              = 0;
        EX_Blez            = 0;
        EX_dstResult       = 0;
        EX_gotoLableResult = 0;
        EX_R1_             = 0;
        EX_R2_             = 0;
        EX_JumpAddr        = 0;
        EX_IR              = 0;
        EX_Reg1            = 0;
        EX_Reg2            = 0;
        EX_Immediate_EX    = 0;
        EX_PCplus4         = 0;
    end else begin
        EX_syscall         = ID_syscall;
        EX_jr              = ID_jr;
        EX_jal             = ID_jal;
        EX_j               = ID_j;
        EX_bne             = ID_bne;
        EX_beq             = ID_beq;
        EX_memToReg        = ID_memToReg;
        EX_memWrite        = ID_memWrite;
        EX_WE              = ID_WE;
        EX_AluSrc          = ID_AluSrc;
        EX_AluOP           = ID_AluOP;
        EX_Lb              = ID_Lb;
        EX_Blez            = ID_Blez;
        EX_dstResult       = ID_dstResult;
        EX_gotoLableResult = ID_gotoLableResult;
        EX_R1_             = ID_R1_;
        EX_R2_             = ID_R2_;
        EX_JumpAddr        = ID_JumpAddr;
        EX_IR              = ID_IR;
        EX_Reg1            = ID_Reg1;
        EX_Reg2            = ID_Reg2;
        EX_Immediate_EX    = ID_Immediate_EX;
        EX_PCplus4         = ID_PCplus4;
    end
end


endmodule
/*
module ID_EX(ID_syscall, ID_jr, ID_jal, ID_j, ID_bne, ID_beq, ID_memToReg, ID_memWrite, ID_WE, ID_AluSrc, ID_AluOP, ID_Lb, ID_Blez, ID_dstResult, ID_gotoLableResult, ID_R1_, ID_R2_, ID_JumpAddr, ID_IR, ID_Reg1, ID_Reg2, ID_Immediate_EX, ID_PCplus4, clk, clr, EX_syscall, EX_jr, EX_jal, EX_j, EX_bne, EX_beq, EX_memToReg, EX_memWrite, EX_WE, EX_AluSrc, EX_AluOP, EX_Lb, EX_Blez, EX_dstResult, EX_gotoLableResult, EX_R1_, EX_R2_, EX_JumpAddr, EX_IR, EX_Reg1, EX_Reg2, EX_Immediate_EX, EX_PCplus4);
input [31:0] ID_gotoLableResult, ID_JumpAddr, ID_IR, ID_Reg1, ID_Reg2, ID_Immediate_EX, ID_PCplus4;
input [4:0] ID_dstResult, ID_R1_, ID_R2_;
input [3:0] ID_AluOP;
input ID_syscall, ID_jr, ID_jal, ID_j, ID_bne, ID_beq, ID_memToReg, ID_memWrite, ID_WE, ID_Lb, ID_Blez, clk, clr, ID_AluSrc;
output [31:0] EX_gotoLableResult, EX_JumpAddr, EX_IR, EX_Reg1, EX_Reg2, EX_Immediate_EX, EX_PCplus4;
output [4:0] EX_dstResult, EX_R1_, EX_R2_;
output [3:0] EX_AluOP;
output EX_syscall, EX_jr, EX_jal, EX_j, EX_bne, EX_beq, EX_memToReg, EX_memWrite, EX_WE, EX_Lb, EX_Blez, EX_AluSrc;
wire en;
assign en = (1);

register32 regLableResult(ID_gotoLableResult, en, clk, EX_gotoLableResult, clr);
register32 regJAddr(ID_JumpAddr, en, clk, EX_JumpAddr, clr);
register32 regIR(ID_IR, en, clk, EX_IR, clr);
register32 regReg1(ID_Reg1, en, clk, EX_Reg1, clr);
register32 regReg2(ID_Reg1, en, clk, EX_Reg2, clr);
register32 regImme(ID_Immediate_EX, en, clk, EX_Immediate_EX, clr);
register32 regPC4(ID_PCplus4, en, clk, EX_PCplus4, clr);
register5 regDst(ID_dstResult, en, clk, EX_dstResult, clr);
register5 regR1_(ID_R1_, en, clk, EX_R1_, clr);
register5 regR2_(ID_R2_, en, clk, EX_R2_, clr);
register4 regAluOp(ID_AluOP, en, clk, EX_AluOP, clr);
register1 regSyscall(ID_syscall, en, clk, EX_syscall, clr);
register1 regJr(ID_jr, en, clk, EX_jr, clr);
register1 regJal(ID_jal, en, clk, EX_jal, clr);
register1 regJ(ID_j, en, clk, EX_j, clr);
register1 regBne(ID_bne, en, clk, EX_bne, clr);
register1 regBeq(ID_beq, en, clk, EX_beq, clr);
register1 regMtoReg(ID_memToReg, en, clk, EX_memToReg, clr);
register1 regMWrite(ID_memWrite, en, clk, EX_memWrite, clr);
register1 regWE(ID_WE, en, clk, EX_WE, clr);
register1 regLb(ID_Lb, en, clk, EX_Lb, clr);
register1 regBlez(ID_Blez, en, clk, EX_Blez, clr);

endmodule
*/
