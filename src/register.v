`timescale 1ns / 1ps

module register(
    input clk,
    input reg_write,
    input [2:0] rs,
    input [2:0] rt,
    input [2:0] rd,
    input [15:0] write_data,

    output [15:0] read_data1,
    output [15:0] read_data2
);

reg [15:0] registers [0:7];

integer i;

initial begin
    for (i = 0; i < 8; i = i + 1)
        registers[i] = 16'd0;
end

assign read_data1 = registers[rs];
assign read_data2 = registers[rt];

always @(posedge clk)
begin
    if(reg_write && rd!=3'd0)
        registers[rd] <= write_data;
end

endmodule
