`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 17:06:56
// Design Name:
// Module Name: IF_ID
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


module IF_ID(IF_inst, IF_PCplus4, en, clk, clr, ID_inst, ID_PCplus4);
input [31:0] IF_inst, IF_PCplus4;
input en, clk, clr;
output ID_inst, ID_PCplus4;

register32 regI(IF_inst, en, clk, ID_inst, clr);
register32 regPC4(IF_PCplus4, en, clk, ID_PCplus4, clr);
endmodule
