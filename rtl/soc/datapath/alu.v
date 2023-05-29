/*
* Module : alu
* Author : Evan.Park
* Date   : May 29, 2023
* Description: This module implements the functionality of Arithmetic or logical operation units
*/
`timescale 1ns / 1ps
`include "../../common/definitions.vh"

module alu
#(
	parameter DWIDTH=32,
    parameter ALU_CONTOL_WIDTH=4
)
(
    input  [DWIDTH-1              : 0] i_alu_in1,
    input  [DWIDTH-1              : 0] i_alu_in2,
    input  [ALU_CONTOL_WIDTH-1    : 0] i_alu_ctrl,
    output [DWIDTH-1              : 0] o_alu_result
);

    wire is_sub;
    wire is_use_adder;
    wire is_or;
    assign is_sub       = i_alu_ctrl[2];
    assign is_use_adder = i_alu_ctrl[1];
    assign is_or        = i_alu_ctrl[0];

    wire [DWIDTH-1:0] inv_in1;
    wire [DWIDTH-1:0] io_adder_out;
    wire [DWIDTH-1:0] and_or_out;
    assign inv_in1      = (is_sub==0) ? i_alu_in1 : ~i_alu_in1;
    assign io_adder_out =  i_alu_in2 + inv_in1 + is_sub;
    assign and_or_out   = (is_or==0) ? (i_alu_in1 & i_alu_in2) : (i_alu_in1) | (i_alu_in2);
    assign o_alu_result = (is_use_adder == 0) ? and_or_out : io_adder_out ;

endmodule