`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 10:12:30
// Design Name:
// Module Name: RAM
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


module RAM(Addr, Din, WE, clk, reset, Dout);
input [9:0] Addr;
input [31:0] Din;
input WE, clk, reset;
output [31:0] Dout;
integer i;

reg [31:0] ramUnity[0:1023];

always @ (posedge clk or reset) begin
    if (reset) begin
        for(i = 0;i<1024;i = i + 1) ramUnity[i] = 0;
    end else begin
        if (WE) begin
            ramUnity[Addr] = Din;
        end
    end
end

assign Dout = (ramUnity[Addr]);

endmodule
