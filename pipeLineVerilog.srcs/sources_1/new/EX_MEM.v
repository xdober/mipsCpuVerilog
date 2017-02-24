`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 21:01:37
// Design Name:
// Module Name: EX_MEM
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


module EX_MEM(
    input EX_syscall, input EX_Jal, input EX_memToReg, input EX_memWrite, input EX_WE, input EX_Lb, input [4:0] EX_dstResult, input [31:0] EX_IR, input [31:0] EX_AluResult, input [31:0] EX_Reg2, input [31:0] EX_PCplus4, input clk, output MEM_syscall, output MEM_Jal, output MEM_memToReg, output MEM_memWrite, output MEM_WE, output MEM_Lb, output [4:0] MEM_dstResult, output [31:0] MEM_IR, output [31:0] MEM_AluResult, output [31:0] MEM_Reg2, output [31:0] MEM_PCplus4
    );
    register1 regSyscall(EX_syscall, 1, clk, MEM_syscall, 0);
    register1 regJal(EX_Jal, 1, clk, MEM_Jal, 0);
    register1 regMtoReg(EX_memToReg, 1, clk, MEM_memToReg, 0);
    register1 regMWrite(EX_memWrite, 1, clk, MEM_memWrite, 0);
    register1 regWE(EX_WE, 1, clk, MEM_WE, 0);
    register1 regLb(EX_Lb, en, clk, MEM_Lb, clr);
    register5 regDst(EX_dstResult, 1, clk, MEM_dstResult, 0);
    register32 regIR(EX_IR, 1, clk, MEM_IR, 0);
    register32 regAluResult(EX_AluResult, 1, clk, MEM_AluResult, 0);
    register32 regReg2(EX_Reg2, 1, clk, MEM_Reg2, 0);
    register32 regPC4(EX_PCplus4, 1, clk, MEM_PCplus4, 0);

endmodule
