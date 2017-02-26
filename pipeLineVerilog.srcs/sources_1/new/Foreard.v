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
wire ling, sec10, sec11, sec20, sec21;
assign ling = 0;
detector dct10(R1_, RwPre_, wePre, memtoRegPre, sec10);
detector dct11(R1_, RwPrePre_, wePrePre, ling, sec11);
detector dct20(R2_, RwPre_, wePre, memtoRegPre, sec20);
detector dct21(R2_, RwPrePre_, wePrePre, ling, sec21);
assign R1_FW = (sec10) ? 2'b01 : (sec11 ? 2'b10 : 2'b00);
assign R2_FW = (sec20) ? 2'b01 : (sec21 ? 2'b10 : 2'b00);

endmodule

module detector (R_, RwPre_, we, memtoReg, FW);
input [4:0] R_, RwPre_;
input we, memtoReg;
output FW;
assign FW = (we && !memtoReg && R_ && R_==RwPre_);
endmodule // detector
