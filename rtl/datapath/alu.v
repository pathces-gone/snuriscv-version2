`timescale 1ns / 1ps

module alu(
    input  [31:0] i_alu_in1,
    input  [31:0] i_alu_in2,
    input  [3 :0] i_alu_ctrl,
    output [31:0] o_alu_out
);

`define FN_ADD  2'b0010  
`define FN_SUB  2'b0110
`define FN_AND  2'b0000
`define FN_OR   2`b0001

wire is_sub;
wire is_use_adder;
wire is_or;
assign is_sub         = i_alu_ctrl[2];
assign is_use_adder   = i_alu_ctrl[1];
assign is_or          = i_alu_ctrl[0];

wire [31:0] inv_in1;
wire [31:0] io_adder_out;
wire [31:0] and_or_out;
assign inv_in1        = (is_sub==0) ? i_alu_in1 : ~i_alu_in1;
assign io_adder_out   = i_alu_in2 + inv_in1 + is_sub;
assign and_or_out     = (is_or==0) ? (i_alu_in1 & i_alu_in2) : (i_alu_in1) | (i_alu_in2);
assign o_alu_out      = (is_use_adder == 0) ? and_or_out : io_adder_out ;

endmodule