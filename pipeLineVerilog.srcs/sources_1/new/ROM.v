`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 10:46:23
// Design Name:
// Module Name: ROM
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


module ROM(Addr, Dout);
input [9:0] Addr;
output [31:0] Dout;
reg [31:0] romUnity[0:1023];
initial begin
    $readmemh("benchmark.hex",romUnity,0,1023);
end
assign Dout = romUnity[Addr];
endmodule
