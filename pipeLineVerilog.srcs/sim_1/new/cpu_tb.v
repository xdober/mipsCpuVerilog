`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/24 15:41:26
// Design Name:
// Module Name: cpu_tb
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


module cpu_tb();
reg clkin, reset, power;
completeCPU cpu(clkin, reset, power);
initial begin
    #5000 $finish;
end
initial begin
    for(clkin = 0; 1; ) #1 clkin = clkin + 1;
end
initial begin
    reset    = 0;
    #2 reset = 1;
    #10 reset = 0;
end
endmodule
