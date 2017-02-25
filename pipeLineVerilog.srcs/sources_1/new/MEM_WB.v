`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 21:30:55
// Design Name:
// Module Name: MEM_WB
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

module MEM_WB(input MEM_syscall, input MEM_Jal, input MEM_WE, input [4:0] MEM_RW, input [31:0] MEM_Din, input [31:0] MEM_IR, input [31:0] MEM_PCplus4, input clk, input reset, output reg WB_syscall, output reg WB_Jal, output reg WB_WE, output reg [4:0] WB_RW, output reg [31:0] WB_Din, output reg [31:0] WB_IR, output reg [31:0] WB_PCplus4
    );
always @ (posedge clk) begin
    if (reset) begin
        WB_syscall = 0;
        WB_Jal     = 0;
        WB_WE      = 0;
        WB_RW      = 0;
        WB_Din     = 0;
        WB_IR      = 0;
        WB_PCplus4 = 0;
    end else begin
        WB_syscall = MEM_syscall;
        WB_Jal     = MEM_Jal;
        WB_WE      = MEM_WE;
        WB_RW      = MEM_RW;
        WB_Din     = MEM_Din;
        WB_IR      = MEM_IR;
        WB_PCplus4 = MEM_PCplus4;
    end
end
endmodule
/*
module MEM_WB(input MEM_syscall, input MEM_Jal, input MEM_WE, input [4:0] MEM_RW, input [31:0] MEM_Din, input [31:0] MEM_IR, input [31:0] MEM_PCplus4, input clk, input reset, output WB_syscall, output WB_Jal, output WB_WE, output [4:0] WB_RW, output [31:0] WB_Din, output [31:0] WB_IR, output [31:0] WB_PCplus4
    );
    register1 regSyscall(MEM_syscall, 1, clk, WB_syscall, reset);
    register1 regJal(MEM_Jal, 1, clk, WB_Jal, reset);
    register1 regWE(MEM_WE, 1, clk, WB_WE, reset);
    register5 regRW(MEM_RW, 1, clk, WB_RW, reset);
    register32 regDin(MEM_Din, 1, clk, WB_Din, reset);
    register32 regIR(MEM_IR, 1, clk, WB_IR, reset);
    register32 regPC4(MEM_PCplus4, 1, clk, WB_PCplus4, reset);
endmodule
*/
