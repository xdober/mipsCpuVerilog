`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 14:54:09
// Design Name:
// Module Name: Bubble
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


module Bubble(clk, LW_LB, R1_, R2_, RW_Mem, IF_en, ID_en, EX_clr, BubbleNum, reset);
input clk, LW_LB, reset;
input [4:0] R1_, R2_, RW_Mem;
output IF_en, ID_en, EX_clr;
output [31:0] BubbleNum;
wire R1blb, R2blb, RRblb;
reg [31:0] count;
reg clr_reg;
assign R1blb = (LW_LB && R1_ && RW_Mem==R1_);
assign R2blb = (LW_LB && R2_ && RW_Mem==R2_);
assign RRblb = (R1blb | R2blb);
always @ (negedge clk) begin
    if (!reset) begin
        clr_reg = RRblb;
    end else begin
        clr_reg = 0;
    end
end
always @ (posedge clk) begin
    if (!reset) begin
        if (RRblb) begin
            count = count+1;
        end
    end else begin
        count = 0;
    end
end
assign EX_clr = (clk & clr_reg);
assign BubbleNum = (count);
assign IF_en = reset ? 1 : (!RRblb);
assign ID_en = reset ? 1 : (!RRblb);

endmodule
