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
reg [3:0] RAM_addr;
wire [31:0] RAM_data, load_use_num, clk_num, a0Value;
completeCPU cpu(clkin, reset, power, a0Value, clk_num, load_use_num, RAM_addr, RAM_data);
initial begin
    #5000 $finish;
end
initial begin
    for(clkin = 0; 1; ) #1 clkin = clkin + 1;
end
initial begin
    reset    = 0; power = 1;
    RAM_addr = 0;
    #2 reset = 1;
    #10 reset = 0;
end
endmodule
