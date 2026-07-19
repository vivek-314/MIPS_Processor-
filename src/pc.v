`timescale 1ns / 1ps

module pc(
    input clk,
    input reset,
    input [15:0] pc_next,
    output reg [15:0] pc
);

always @(posedge clk or posedge reset)
begin
    if (reset)
        pc <= 16'd0;
    else
        pc <= pc_next;
end

endmodule
