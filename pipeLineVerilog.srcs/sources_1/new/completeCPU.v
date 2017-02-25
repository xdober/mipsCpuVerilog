`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/23 22:22:00
// Design Name:
// Module Name: completeCPU
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


module completeCPU(input clk_100mhz, input reset, input power,
    output reg [7:0] location, output reg [7:0] temp);

//global variables
wire clkin, clk, flash;

//IF variables
wire [31:0] PCFromJump, PCFromJr, PCFromBranch, PC_IF, IF_PCplus4, IF_ins;
reg [31:0] PC_reg;

//ID variables
wire [31:0] ID_ins, ID_PCplus4, ID_JumpAddr, ID_imme16_EX_S, ID_imme16_EX_U,
    ID_imme5_EX_U, ID_gotoLableResult, ID_Reg1, ID_Reg2, v0Value, a0Value,
    s2value, raValue, ID_Immediate_EX;
wire [15:0] ID_imme16;
wire [4:0] ID_imme5, ID_rt, ID_rs, ID_rd, ID_R1_, ID_R2_, ID_dstResult;
wire [3:0] ID_AluOP;
wire clr_ID, ID_ext_u, ID_alu_src, ID_s_i, ID_reg_dst, ID_reg_write,
    ID_mem_write, ID_memtoReg, ID_Beq, ID_Bne, ID_j, ID_jal, ID_jr, ID_Syscall,
    ID_Blez, ID_Lb;

//EX variables
wire [31:0] EX_gotoLableResult, EX_JumpAddr, EX_IR, EX_Reg1, EX_Reg2,
    EX_Immediate_EX, EX_PCplus4, ALU_Xin, JrAddr, EX_memDate, Alu_Yin,
    EX_AluResult;
wire [4:0] EX_dstResult, EX_R1_, EX_R2_;
wire [3:0] EX_AluOP;
wire [1:0] Reg1_OP, Reg2_OP;
wire EX_clr, EX_syscall, EX_jr, EX_jal, EX_j, EX_bne, EX_beq, EX_memToReg,
    EX_memWrite, EX_WE, EX_AluSrc, EX_Lb, EX_Blez, EX_JorJRorJAL, EX_isEqual,
    branchNum, clr_IF_ID, branchSuccess;
reg clr_IF_ID_reg, EX_JorJRorJAL_reg;

//MEM variables
wire [31:0] MEM_IR, MEM_AluResult, MEM_memDate, MEM_PCplus4, memDout, MEM_Din,
    ByteEXT;
wire [9:0] memAddr;
wire [7:0] memDataByte;
wire [4:0] MEM_dstResult, MEM_RW;
wire MEM_syscall, MEM_Jal, MEM_memToReg, MEM_memWrite, MEM_WE, MEM_Lb;

//WB variables
wire [31:0] WB_Dout, WB_IR, WB_PCplus4, WB_Din;
wire [4:0] WB_RW;
wire WB_syscall, WB_Jal, WB_WE;

//Bubble & Forward & clk generate variables
wire [31:0] BubbleNum, clk_num, load_use_num;
wire en_PC, en_ID, SyscallAddOne;
reg [31:0] clk_num_no_syscall, branch_num, jump_num;

//Digital display variables
wire [3:0] a0[0:7];
wire [7:0] display[0:7];
reg [2:0] k;

//IF
assign PCFromJump = (EX_j || EX_jal) ? EX_JumpAddr : IF_PCplus4;
assign PCFromJr = (EX_jr) ? JrAddr : PCFromJump;
assign PCFromBranch = (branchSuccess) ? EX_gotoLableResult : PCFromJr;
always @ (posedge clk) begin
    if (reset) begin
        PC_reg = 0;
    end else begin
        if (en_PC) begin
            PC_reg = PCFromBranch;
        end
    end
end
assign PC_IF = (PC_reg);

assign IF_PCplus4 = (4 + PC_IF);
ROM iROM(PC_IF[11:2], IF_ins);


//IF --> ID
IF_ID if_id(IF_ins, IF_PCplus4, en_ID, clk, clr_ID, ID_ins, ID_PCplus4);
assign clr_ID = (EX_JorJRorJAL | clr_IF_ID | reset);


//ID
CtlUnity ctl(ID_ins[31:26], ID_ins[5:0], ID_ins[20:16], ID_AluOP, ID_ext_u,
    ID_alu_src, ID_s_i, ID_reg_dst, ID_reg_write, ID_mem_write, ID_memtoReg,
    ID_Beq, ID_Bne, ID_j, ID_jal, ID_jr, ID_Syscall, ID_Lb, ID_Blez);
assign ID_rt = (ID_ins[20:16]);
assign ID_rs = (ID_ins[25:21]);
assign ID_rd = (ID_ins[15:11]);

assign ID_R1_ = (ID_s_i) ? ID_rt : ID_rs;
assign ID_R2_ = (ID_rt);

assign ID_imme16 = (ID_ins[15:0]);
assign ID_JumpAddr = ({ID_PCplus4[31:28],ID_ins[25:0],2'b00});
assign ID_imme5 = (ID_ins[10:6]);
signed_16to32 sgn16_1(ID_imme16, ID_imme16_EX_S);
unsigned_16to32 usgn16_1(ID_imme16, ID_imme16_EX_U);
unsigned_5to32 usn5_1(ID_imme5, ID_imme5_EX_U);
assign ID_gotoLableResult = (ID_PCplus4 + (ID_imme16_EX_S << 2));
assign ID_dstResult = (ID_reg_dst) ? ID_rd : ID_rt;
assign ID_Immediate_EX = (ID_s_i) ? ID_imme5_EX_U : (ID_ext_u ? ID_imme16_EX_U : ID_imme16_EX_S);
regfile regfile0(ID_R1_, ID_R2_, WB_RW, WB_Din, WB_WE, clk, ID_Reg1, ID_Reg2,
    v0Value, a0Value, s2value, raValue, reset
    );

//ID --> EX
assign EX_clrclr = (EX_clr | clr_IF_ID | EX_JorJRorJAL | reset);
ID_EX id_ex(ID_Syscall, ID_jr, ID_jal, ID_j, ID_Bne, ID_Beq, ID_memtoReg,
    ID_mem_write, ID_reg_write, ID_alu_src, ID_AluOP, ID_Lb, ID_Blez, ID_dstResult,
    ID_gotoLableResult, ID_R1_, ID_R2_, ID_JumpAddr, ID_ins, ID_Reg1, ID_Reg2,
    ID_Immediate_EX, ID_PCplus4, clk, EX_clrclr, EX_syscall, EX_jr, EX_jal, EX_j,
    EX_bne, EX_beq, EX_memToReg, EX_memWrite, EX_WE, EX_AluSrc, EX_AluOP, EX_Lb,
    EX_Blez, EX_dstResult, EX_gotoLableResult, EX_R1_, EX_R2_, EX_JumpAddr,
    EX_IR, EX_Reg1, EX_Reg2, EX_Immediate_EX, EX_PCplus4
    );

//EX
always @ (negedge clk) begin//Jump ctrl
    if (reset) begin
        EX_JorJRorJAL_reg = 0;
    end else begin
        EX_JorJRorJAL_reg = (EX_j | EX_jal | EX_jr);
    end
end
assign EX_JorJRorJAL = (EX_JorJRorJAL_reg & clk);

assign ALU_Xin = (Reg1_OP[1]) ? WB_Din : (Reg1_OP[0] ? MEM_AluResult : EX_Reg1);
assign JrAddr = (ALU_Xin);
assign EX_memDate = (Reg2_OP[1]) ? WB_Din : (Reg2_OP[0] ? MEM_AluResult : EX_Reg2);
assign Alu_Yin = (EX_AluSrc) ? EX_Immediate_EX : EX_memDate;
ALU alu(ALU_Xin, Alu_Yin, EX_AluOP, EX_AluResult, EX_isEqual, reset);

assign branchNum = ((EX_bne & !EX_isEqual) | (EX_beq & EX_isEqual) | (EX_Blez & (EX_isEqual | EX_AluResult[0])) ); //branch ctrl
assign branchSuccess = (branchNum);
always @ (negedge clk) begin
    if (reset) begin
        clr_IF_ID_reg = 0;
    end else begin
        clr_IF_ID_reg = branchNum;
    end
end
assign clr_IF_ID = (clr_IF_ID_reg & clk);



//EX --> MEM
EX_MEM ex_mem(EX_syscall, EX_jal, EX_memToReg, EX_memWrite, EX_WE, EX_Lb,
    EX_dstResult, EX_IR, EX_AluResult, EX_memDate, EX_PCplus4, clk, reset, MEM_syscall,
    MEM_Jal, MEM_memToReg, MEM_memWrite, MEM_WE, MEM_Lb, MEM_dstResult, MEM_IR,
    MEM_AluResult, MEM_memDate, MEM_PCplus4
    );

//MEM
assign memAddr = (MEM_AluResult[11:2]);
RAM dRAM(memAddr, MEM_memDate, MEM_memWrite, clk, reset, memDout);
assign MEM_RW = (MEM_Jal) ? 5'h1f : MEM_dstResult;
assign memDataByte = (MEM_AluResult[1]) ?
    (MEM_AluResult[0] ? memDout[31:24] : memDout[23:16]) :
    (MEM_AluResult[0] ? memDout[15:8] : memDout[7:0]);
signed_8to32 byteE(memDataByte, ByteEXT);
assign MEM_Din = (MEM_Jal) ?
    MEM_PCplus4 :
    (MEM_memToReg ?(MEM_Lb ? ByteEXT : memDout) :MEM_AluResult);

//MEM --> WB
MEM_WB mem_wb(MEM_syscall, MEM_Jal, MEM_WE, MEM_RW, MEM_Din, MEM_IR, MEM_PCplus4,
    clk, reset, WB_syscall, WB_Jal, WB_WE, WB_RW, WB_Dout, WB_IR, WB_PCplus4
    );

//WB
assign WB_Din = (WB_Jal) ? WB_PCplus4 : WB_Dout;

//Forward
Forward fw(EX_R1_, EX_R2_, MEM_dstResult, WB_RW, MEM_WE, WB_WE, MEM_memToReg,
    Reg1_OP, Reg2_OP
    );

//Bubble
Bubble bubl(clk, EX_memToReg, ID_R1_, ID_R2_, EX_dstResult, en_PC, en_ID,
    EX_clr, BubbleNum, reset
    );

//ins counting
always @ (posedge clk or posedge reset) begin
    if (reset) begin
        clk_num_no_syscall = 0;
        branch_num         = 0;
        jump_num           = 0;
    end else begin
        clk_num_no_syscall = clk_num_no_syscall + 1;
        if (branchSuccess) begin
            branch_num = branch_num + 1;
        end
        if (EX_j | EX_jal | EX_jr) begin
            jump_num = jump_num + 1;
        end
    end
end
assign clk_num = (clk_num_no_syscall + SyscallAddOne);
assign load_use_num = (BubbleNum);


//clk generate
Hz hz(clk_100mhz, clkin);
clkgenerate clkgnrt(v0Value, WB_syscall, clkin, SyscallAddOne, clk);

//16bits Digital display
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
            if(!reset) begin
                location = 8'b11111110;
                temp=display[0];
            end else begin
                location = 8'b11111111;
            end
        end
	3'b001:begin
            if(!reset) begin
                location = 8'b11111101;
                temp=display[1];
            end else begin
                location = 8'b11111111;
            end
        end
	3'b010:begin
            if(!reset) begin
                location = 8'b11111011;
                temp=display[2];
            end else begin
                location = 8'b11111111;
            end
        end
	3'b011:begin
            if(!reset) begin
                location = 8'b11110111;
                temp=display[3];
            end else begin
                location = 8'b11111111;
            end
        end
	3'b100:begin
            if(!reset) begin
                location = 8'b11101111;
                temp=display[4];
            end else begin
                location = 8'b11111111;
            end
        end
	3'b101:begin
            if(!reset) begin
                location = 8'b11011111;
                temp=display[5];
            end else begin
                location = 8'b11111111;
            end
        end
	3'b110:begin
            if(!reset) begin
                location = 8'b10111111;
                temp=display[6];
            end else begin
                location = 8'b11111111;
            end
        end
	3'b111:begin
            if(!reset) begin
                location = 8'b01111111;
                temp=display[7];
            end else begin
                location = 8'b11111111;
            end
        end
	default:begin
            location = 8'b00000000;
            temp = 8'b00000000;
        end
	endcase
end

endmodule
