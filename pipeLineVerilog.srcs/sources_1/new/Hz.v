`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/25 20:21:10
// Design Name:
// Module Name: Hz
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


module Hz(power, clk, sec);
input clk, power;//输入100MHZ时钟信号
output sec;//输出200Hz的电平信号
reg [19:0] count;
always @ ( posedge clk ) begin
    if (power) begin
        count = count + 1;
    end
end
initial begin
    count = 0;
end
assign sec = (count[19]);
endmodule
