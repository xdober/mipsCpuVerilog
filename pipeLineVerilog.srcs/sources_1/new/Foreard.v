`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 14:29:19
// Design Name:
// Module Name: Foreard
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


module Forward(R1_, R2_, RwPre_, RwPrePre_, wePre, wePrePre, memtoRegPre, R1_FW, R2_FW);
input [4:0] R1_, R2_, RwPre_, RwPrePre_;
input wePre, wePrePre, memtoRegPre;
output [1:0] R1_FW, R2_FW;
detector dct10(R1_, RwPre_, wePre, memtoRegPre, R1_FW[0]);
detector dct11(R1_, RwPrePre_, wePrePre, 0, R1_FW[1]);
detector dct20(R2_, RwPre_, wePre, memtoRegPre, R2_FW[0]);
detector dct21(R2_, RwPrePre_, wePrePre, 0, R2_FW[1]);
endmodule

module detector (R_, RwPre_, we, memtoReg, FW);
input [4:0] R_, RwPre_;
input we, memtoReg;
output FW;
assign FW = (we & !memtoReg & R_ & R_==RwPre_);
endmodule // detector
