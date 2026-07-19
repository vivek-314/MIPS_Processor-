`timescale 1ns / 1ps

module alu_control(
    input [1:0] alu_op,
    input [3:0] funct,
    output reg [2:0] alu_control
);

always @(*) begin
    case (alu_op)

        2'b00: alu_control = 3'b000; // ADD
        2'b01: alu_control = 3'b001; // SUB (beq)
        2'b11: alu_control = 3'b100; // SLT immediate

        2'b10:
        begin
            case (funct)
                4'b0000: alu_control = 3'b000; // add
                4'b0001: alu_control = 3'b001; // sub
                4'b0010: alu_control = 3'b010; // and
                4'b0011: alu_control = 3'b011; // or
                4'b0100: alu_control = 3'b100; // slt
                default: alu_control = 3'b000;
            endcase
        end

        default:
            alu_control = 3'b000;
    endcase
end

endmodule
