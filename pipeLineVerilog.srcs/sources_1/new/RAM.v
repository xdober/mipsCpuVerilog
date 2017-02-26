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


module RAM(Addr, Din, WE, clk, reset, Dout, RAM_addr, RAM_data);
input [9:0] Addr;
input [3:0] RAM_addr;
input [31:0] Din;
input WE, clk, reset;
output [31:0] Dout, RAM_data;
integer i;

reg [31:0] ramUnit[0:1023];

always @ (posedge clk) begin

        if (WE) begin
            ramUnit[Addr] = Din;
        end
end

assign Dout = (ramUnit[Addr]);
assign RAM_data = (ramUnit[{6'b000000,RAM_addr}]);

endmodule
