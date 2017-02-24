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


module ALU(Xin, Yin, AluOP, result, isEqual);
input signed [31:0] Xin, Yin;
input [3:0] AluOP;
output [31:0] result;
output isEqual;
reg [31:0] rzlt, rzlt2;
always @ ( * ) begin
    if (!reset) begin
        case(AluOP)
        4'b0000:rzlt      = Xin<<Yin;
        4'b0001:rzlt      = Xin>>>Yin;
        4'b0010:rzlt      = Xin>>Yin;
        4'b0011:{rzlt2,rzlt} = Xin*Yin;
        4'b0100:rzlt      = Xin/Yin;
        4'b0101:rzlt      = Xin+Yin;
        4'b0110:rzlt      = Xin-Yin;
        4'b0111:rzlt      = Xin&Yin;
        4'b1000:rzlt      = Xin|Yin;
        4'b1001:rzlt      = Xin^Yin;
        4'b1010:rzlt      = ~(Xin|Yin);
        4'b1011:rzlt      = (Xin<Yin)?1:0;
        4'b1100:rzlt      =  ({1'b0,Xin}<{1'b0,Yin})?1:0;
        endcase
    end else begin
        rzlt = 0;
        isEqual = 0;
    end
end
assign result = (rzlt);
assign isEqual = (Xin==Yin) ? 1 : 0;

endmodule
