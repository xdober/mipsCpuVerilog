`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 16:35:07
// Design Name:
// Module Name: clkgenerate
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


module clkgenerate(v0, isSyscall, clkin, SyscallAddOne, clkout);
input isSyscall, clkin;
input [31:0] v0;
output SyscallAddOne, clkout;

assign SyscallAddOne = (v0==10 && isSyscall);
assign clkout = (clkin || SyscallAddOne);

endmodule
