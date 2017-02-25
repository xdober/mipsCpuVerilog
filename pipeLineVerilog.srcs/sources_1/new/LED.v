`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/25 20:04:09
// Design Name:
// Module Name: LED
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

//input a 8bits number, output a 16bits Digital display signal
module LED(inbcd, out);
    inout [3:0] inbcd;
    output reg [7:0] out;

    always @ ( inbcd )
    begin
        case ( inbcd )
        4'b0000:out = 8'b11000000;
        4'b0001:out = 8'b11111001;
        4'b0010:out = 8'b10100100;
        4'b0011:out = 8'b10110000;
        4'b0100:out = 8'b10011001;
        4'b0101:out = 8'b10010010;
        4'b0110:out = 8'b10000010;
        4'b0111:out = 8'b11111000;
        4'b1000:out = 8'b10000000;
        4'b1001:out = 8'b10010000;
        4'b1010:out = 8'b10001000;//A
        4'b1011:out = 8'b10000011;//b
        4'b1100:out = 8'b11000110;//C
        4'b1101:out = 8'b10100001;//d
        4'b1110:out = 8'b10000110;//E
        4'b1111:out = 8'b10001110;//F
        default:out = 8'b11111111;
        endcase
    end

endmodule
