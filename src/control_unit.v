`timescale 1ns / 1ps

module control_unit(
    input [2:0] opcode,

    output reg reg_dst,
    output reg alu_src,
    output reg mem_to_reg,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg [1:0] alu_op,
    output reg jump,
    output reg jal
);

always @(*) begin

    reg_dst   = 0;
    alu_src   = 0;
    mem_to_reg= 0;
    reg_write = 0;
    mem_read  = 0;
    mem_write = 0;
    branch    = 0;
    jump = 0;
    jal =0;
    alu_op    = 2'b00;

    case(opcode)

        3'b000:
        begin
            reg_dst = 1;
            alu_src = 0;
            mem_to_reg = 0;
            reg_write = 1;
            mem_read = 0;
            mem_write = 0;
            branch = 0;
            alu_op = 2'b10;
        end

        3'b001:
        begin
            reg_dst = 0;
            alu_src = 1;
            mem_to_reg = 0;
            reg_write = 1;
            mem_read = 0;
            mem_write = 0;
            branch = 0;
            alu_op = 2'b11;
        end


        3'b010:
        begin
            reg_dst = 0;
            alu_src = 0;
            mem_to_reg = 0;
            reg_write = 0;
            mem_read = 0;
            mem_write = 0;
            branch = 0;
            alu_op = 2'b00;
            jump =1;
        end


        3'b011:
        begin
            reg_dst = 0;
            alu_src = 0;
            mem_to_reg = 0;
            reg_write = 1;
            mem_read = 0;
            mem_write = 0;
            branch = 0;
            alu_op = 2'b00;
            jump=1;
            jal=1;
        end


        3'b100:
        begin
            reg_dst = 0;
            alu_src = 1;
            mem_to_reg = 1;
            reg_write = 1;
            mem_read = 1;
            mem_write = 0;
            branch = 0;
            alu_op = 2'b00;
        end

        3'b101:
        begin
            reg_dst = 0;
            alu_src = 1;
            mem_to_reg = 0;
            reg_write = 0;
            mem_read = 0;
            mem_write = 1;
            branch = 0;
            alu_op = 2'b00;
        end


        3'b110:
        begin
            reg_dst = 0;
            alu_src = 0;
            mem_to_reg = 0;
            reg_write = 0;
            mem_read = 0;
            mem_write = 0;
            branch = 1;
            alu_op = 2'b01;
        end


        3'b111:
        begin
            reg_dst = 0;
            alu_src = 1;
            mem_to_reg = 0;
            reg_write = 1;
            mem_read = 0;
            mem_write = 0;
            branch = 0;
            alu_op = 2'b00;
        end



        default:
        begin
            reg_dst = 0;
            alu_src = 0;
            mem_to_reg = 0;
            reg_write = 0;
            mem_read = 0;
            mem_write = 0;
            branch = 0;
            alu_op = 2'b00;
            jump=0;
        end
    endcase
end

endmodule
