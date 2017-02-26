`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/22 19:47:42
// Design Name:
// Module Name: ALU
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


module ALU(Xin, Yin, AluOP, result, isEqual, reset);
input [31:0] Xin, Yin;
input [3:0] AluOP;
input reset;
output reg [31:0] result;
output reg isEqual;
reg [31:0] result2;
wire signed [31:0] x_s, y_s;
assign x_s = $signed(Xin);
assign y_s = $signed(Yin);

always @ ( * ) begin
    case(AluOP)
        4'b0000:result      = Xin<<Yin;
        4'b0001:result      = x_s>>>Yin;
        4'b0010:result      = Xin>>Yin;
        4'b0011:{result2,result} = Xin*Yin;
        4'b0100:result      = Xin/Yin;
        4'b0101:result      = Xin+Yin;
        4'b0110:result      = Xin-Yin;
        4'b0111:result      = Xin&Yin;
        4'b1000:result      = Xin|Yin;
        4'b1001:result      = Xin^Yin;
        4'b1010:result      = ~(Xin|Yin);
        4'b1011:result      = (x_s<y_s)?1:0;
        4'b1100:result      = (Xin<Yin)?1:0;
    endcase
    isEqual = (Xin==Yin) ? 1 : 0;
end

endmodule
