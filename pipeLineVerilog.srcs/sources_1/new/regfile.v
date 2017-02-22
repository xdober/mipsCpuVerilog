`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/22 19:38:41
// Design Name:
// Module Name: regfile
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


module regfile(Reg1_, Reg2_, WriteReg_, Din, WriteEnable, clk, Reg1, Reg2, v0Value, a0Value, s2value, raValue);
input WriteEnable, clk;
input [4:0]Reg1_, Reg2_, WriteReg_;
input [31:0]Din;
inout WriteEnable, clk;
output reg[31:0] Reg1, Reg2, v0Value, a0Value, s2value, raValue;
reg [31:0] register[0:31];

assign register[0] = 0;
assign Reg1     = (register[Reg1_]);
assign Reg2     = (register[Reg2_]);
assign v0Value = (register[2]);
assign a0Value = (register[4]);
assign s2value = (register[18]);
assign raValue = (register[31]);

always @ (negedge clk) begin
    if (WriteEnable && !WriteReg_) begin
        register[WriteReg_] = Din;
    end
end
endmodule
