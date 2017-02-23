`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 15:33:51
// Design Name:
// Module Name: regfile_tb
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


module regfile_tb();
reg [4:0] R1, R2, RW;
reg [31:0] Din;
reg WE, clk, clr;
wire [31:0] R1data, R2data, v0Value, a0Value, s2value, raValue;
regfile DUT(R1, R2, RW, Din, WE, clk, R1data, R2data, v0Value, a0Value, s2value, raValue, clr);
initial begin
    #200 $finish;
end
initial begin
    for(clk = 0; 1;) #1 clk = clk + 1;
end

initial begin
    clr=0;
    #5 clr=1;R1=1;R2=2;
    #5 clr=0;WE=1;RW=1;Din=32'h00000001;
    #10 RW=1;Din=32'h00000002;
    #10 RW=1;Din=32'h00000003;
    #10 RW=1;Din=32'h00000005;
    #10 R1=0;R2=4;
end
endmodule
