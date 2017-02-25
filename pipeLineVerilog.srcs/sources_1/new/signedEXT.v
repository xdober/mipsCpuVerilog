`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 14:16:05
// Design Name:
// Module Name: signedEXT
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


module signed_16to32(Din, Dout);
input [15:0] Din;
output [31:0] Dout;
assign Dout = (Din[15]?{16'hffff,Din}:{16'h00,Din});
endmodule

module unsigned_16to32(Din, Dout);
input [15:0] Din;
output [31:0] Dout;
assign Dout = ({16'h00,Din});
endmodule

module signed_8to32(Din, Dout);
input [7:0] Din;
output [31:0] Dout;
assign Dout = (Din[7]?{24'hffffff,Din}:{24'h000,Din});
endmodule

module unsigned_5to32(Din, Dout);
input [4:0] Din;
output [31:0] Dout;
assign Dout = ({27'h0,Din});
endmodule
