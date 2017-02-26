`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/26 11:45:31
// Design Name:
// Module Name: display
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


module display(clk_100mhz, power, reset, location, temp,
    RAM_addr_3, RAM_addr_2, RAM_addr_1, RAM_addr_0,
    sec1, sec0);
input clk_100mhz, power, reset,RAM_addr_3, RAM_addr_2, RAM_addr_1, RAM_addr_0, sec1, sec0;
output reg [7:0] location, temp;
wire [31:0] a0Value, clk_num, branch_num, load_use_num, jump_num, RAM_data;

//Digital display variables
wire [3:0] a0[0:7], RAM_addr;
wire [7:0] display[0:7];
reg [2:0] k;
reg [14:0] flash15;

assign RAM_addr = ({RAM_addr_3, RAM_addr_2, RAM_addr_1, RAM_addr_0});
Hz hz(power, clk_100mhz, clk);
completeCPU cpu0(clk, reset, power, a0Value, clk_num, load_use_num, RAM_addr, RAM_data);

//16bits Digital display
always @ (posedge clk_100mhz) begin
    flash15 = flash15 + 1;
end
assign flash = (flash15[14]);
//00:a0Value, 01: RAM_data, 10:clk_num, 11:load_use_num
//assign {a0[7], a0[6], a0[5], a0[4], a0[3], a0[2], a0[1], a0[0]} =(sec1 ? (sec0 ? load_use_num : clk_num) : (sec0? RAM_data : a0Value));
//assign {a0[7], a0[6], a0[5], a0[4], a0[3], a0[2], a0[1], a0[0]} =(sec1 ? clk_num: a0Value);
assign {a0[7], a0[6], a0[5], a0[4], a0[3], a0[2], a0[1], a0[0]} = (a0Value);

LED led0(a0[0], display[0]);
LED led1(a0[1], display[1]);
LED led2(a0[2], display[2]);
LED led3(a0[3], display[3]);
LED led4(a0[4], display[4]);
LED led5(a0[5], display[5]);
LED led6(a0[6], display[6]);
LED led7(a0[7], display[7]);
always @(posedge flash) begin
	k = k + 1;
end
always @( k ) begin
	case ( k )
	3'b000:begin
            location = 8'b11111110;
            temp=display[0];
        end
	3'b001:begin
            location = 8'b11111101;
            temp=display[1];
        end
	3'b010:begin
            location = 8'b11111011;
            temp=display[2];
        end
	3'b011:begin
            location = 8'b11110111;
            temp=display[3];
        end
	3'b100:begin
            location = 8'b11101111;
            temp=display[4];
        end
	3'b101:begin
            location = 8'b11011111;
            temp=display[5];
        end
	3'b110:begin
            location = 8'b10111111;
            temp=display[6];
        end
	3'b111:begin
            location = 8'b01111111;
            temp=display[7];
        end
	default:begin
            location = 8'b00000000;
            temp = 8'b00000000;
        end
	endcase
end
endmodule
