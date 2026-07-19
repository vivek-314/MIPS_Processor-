`timescale 1ns / 1ps

module mips_processor(
    input clk,
    input reset
);

wire [15:0] pc;
wire [15:0] pc_next;
wire [15:0] instruction;

wire reg_dst;
wire alu_src;
wire mem_to_reg;
wire reg_write;
wire mem_read;
wire mem_write;
wire branch;
wire [1:0] alu_op;

wire [2:0] alu_control;

wire [15:0] read_data1;
wire [15:0] read_data2;

wire [15:0] imm_ext;

wire [15:0] alu_b;
wire [15:0] alu_result;

wire [15:0] mem_read_data;

wire [15:0] write_back_data;

wire zero;

wire [2:0] write_reg;

wire jump;
wire[15:0] jump_addr;

wire jal;


pc pc0(.clk(clk),.reset(reset),.pc_next(pc_next),.pc(pc));
wire [15:0] pc_plus2;
wire [15:0] branch_addr;

wire jr;
assign jr = (opcode == 3'b000) && (funct == 4'b1000);

assign pc_plus2 = pc + 16'd2;
assign branch_addr = pc_plus2 + (imm_ext << 1);

assign pc_next =
    jr ? read_data1 :
    jump ? jump_addr :
    (branch && zero) ? branch_addr :
                       pc_plus2;

instruction_memory imem(.address(pc),.instruction(instruction));

wire [2:0] opcode;
wire [2:0] rs;
wire [2:0] rt;
wire [2:0] rd;
wire [3:0] funct;
wire [6:0] imm;

assign opcode = instruction[15:13];
assign rs     = instruction[12:10];
assign rt     = instruction[9:7];
assign rd     = instruction[6:4];
assign funct  = instruction[3:0];
assign imm    = instruction[6:0];

control_unit cu(
    .opcode(opcode),
    .reg_dst(reg_dst),
    .alu_src(alu_src),
    .mem_to_reg(mem_to_reg),
    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .branch(branch),
    .alu_op(alu_op),
    .jump(jump),
    .jal(jal)
);

assign jump_addr = {2'b00, instruction[12:0], 1'b0};
                 
assign write_reg = (jal) ? 3'b111 :
                   (reg_dst) ? rd : rt;

register rf(
    .clk(clk),
    .reg_write(reg_write),
    .rs(rs),
    .rt(rt),
    .rd(write_reg),
    .write_data(write_back_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

sign_extend se(
    .imm(imm),
    .imm_ext(imm_ext)
);

alu_control ac(
    .alu_op(alu_op),
    .funct(funct),
    .alu_control(alu_control)
);

assign alu_b =(alu_src) ? imm_ext : read_data2;

alu alu0(
    .a(read_data1),
    .b(alu_b),
    .alu_control(alu_control),
    .result(alu_result),
    .zero(zero)
);

data_memory dm(
    .clk(clk),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .address(alu_result),
    .write_data(read_data2),
    .read_data(mem_read_data)
);

assign write_back_data =
    (jal) ? pc_plus2 :
    (mem_to_reg) ? mem_read_data :
                   alu_result;
                   
endmodule
