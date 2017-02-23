`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 16:58:22
// Design Name:
// Module Name: register
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


module register32(Din, en, clk, Dout, clr);
input [31:0] Din;
input en, clk, clr;
output [31:0] Dout;
reg [31:0] data;
always @ (posedge clk or clr) begin
    if (clr) begin
        data = 0;
    end else begin
        if (en) begin
            data = Din;
        end
    end
end
assign Dout = data;
endmodule

module register5(Din, en, clk, Dout, clr);
input [4:0] Din;
input en, clk, clr;
output [4:0] Dout;
reg [4:0] data;
always @ (posedge clk or clr) begin
    if (clr) begin
        data = 0;
    end else begin
        if (en) begin
            data = Din;
        end
    end
end
assign Dout = data;
endmodule

module register4(Din, en, clk, Dout, clr);
input [3:0] Din;
input en, clk, clr;
output [3:0] Dout;
reg [3:0] data;
always @ (posedge clk or clr) begin
    if (clr) begin
        data = 0;
    end else begin
        if (en) begin
            data = Din;
        end
    end
end
assign Dout = data;
endmodule

module register1(Din, en, clk, Dout, clr);
input Din;
input en, clk, clr;
output Dout;
reg data;
always @ (posedge clk or clr) begin
    if (clr) begin
        data = 0;
    end else begin
        if (en) begin
            data = Din;
        end
    end
end
assign Dout = data;
endmodule
