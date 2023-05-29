/*
* Module : pcgen
* Author : Evan.Park
* Date   : May 29, 2023
* Description: This module implements the functionality of program-counter generation.
*/
`timescale 1ns / 1ps
`include "../../common/definitions.vh"

module pcgen
#(
    parameter AWIDTH=32,
    parameter ADDR_BYTE=AWIDTH>>3
)
(
    input  [AWIDTH-1:0] i_pc0,
    input  [ 1:0]       i_pc_sel,
    input  [AWIDTH-1:0] i_jump_reg_target,
    input  [AWIDTH-1:0] i_brjmp_target,
    output [AWIDTH-1:0] o_npc
);

    wire [AWIDTH-1:0] add_pc;
    assign add_pc = i_pc0 + ADDR_BYTE;
    assign o_npc    = (i_pc_sel == `PC_SEL_STATE_ADD)         ? add_pc
                    : (i_pc_sel == `PC_SEL_STATE_BRANCH_JUMP) ? i_brjmp_target
                    : (i_pc_sel == `PC_SEL_STATE_REG_JUMP)    ? i_jump_reg_target
                    : `INITIAL_PC_VALUE;
endmodule