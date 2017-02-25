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


module Hz(power, clk, sec, flash);
input clk, power;//输入100MHZ时钟信号
output reg sec, flash;//输出200Hz的电平信号
integer count;
always @ ( posedge clk ) begin
    if (power) begin
        if (count < 250000) begin
            count = count + 1;
            sec = 0;
            flash = 0;
        end else begin
            if (count < 500000) begin
                count = count + 1;
                sec = 1;
                flash = 1;
            end else begin
                count = 0;
            end
        end
    end
end
endmodule
