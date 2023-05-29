/*
* Module : frontend
* Author : Evan.Park
* Date   : May 29, 2023
* Description: This module is frontend module, which is fabricated Fetch, pcgen, branch-prediction, etc.
*/
`timescale 1ns / 1ps
`include "../common/definitions.vh"

module frontend
#(
    parameter AWIDTH=32,
    parameter DWIDTH=AWIDTH,
    parameter ADDR_BYTE=AWIDTH>>3
)
(
    input  i_clk,
    input  i_reset,
    input  i_alu_not_taken,
    input  i_icache_rnw,        //Now is Read-only 1
    input  i_icache_rq,
    input  [DWIDTH-1:0] i_inst, //write to I$, Now is dont care.
    output [DWIDTH-1:0] o_inst
);
    reg  [AWIDTH-1:0] reg_pc;
    
    // OPDECODER
    wire [6:0] opcode;

    // PCGEN
    wire [AWIDTH-1:0] jump_reg_target;
    wire [AWIDTH-1:0] brjmp_target;
    wire [1:0]        taken;
    wire [1:0]        pc_sel;

    wire [DWIDTH-1:0] inst_fetched;
    icache icache_m0(
        .i_reset  (i_reset),
        .i_clk    (i_clk),
        .i_mem_rq (i_icache_rq),
        .i_rnw    (i_icache_rnw),
        .i_pc     (reg_pc),
        .i_data   (i_inst),
        .o_data   (inst_fetched)
    );

    assign o_inst = inst_fetched;

    opcode_decoder opcode_decoder_m0(
        .i_inst    (inst_fetched),
        .o_opcode  (opcode)
    );


    /*PCGEN*/
    assign brjmp_target   = 0;
    assign jump_reg_target= 0;
    assign taken    = (i_alu_not_taken == 0) ? `PC_SEL_STATE_BRANCH_JUMP 
                                             : `PC_SEL_STATE_ADD;
    assign pc_sel   = (reg_pc == `INITIAL_PC_VALUE)? `PC_SEL_STATE_ADD
                    : (opcode == `J_FORMAT)  ? `PC_SEL_STATE_REG_JUMP
                    : (opcode == `U_FORMAT)  ? `PC_SEL_STATE_BRANCH_JUMP
                    : (opcode == `S_FORMAT)  ? `PC_SEL_STATE_ADD
                    : (opcode == `R_FORMAT)  ? `PC_SEL_STATE_ADD
                    : (opcode == `SB_FORMAT) ? taken
                    : `PC_SEL_STATE_ADD;

    wire [AWIDTH-1:0] next_pc;
    pcgen pcgen_m0(
        .i_pc0            (reg_pc),
        .i_pc_sel         (pc_sel),
        .i_jump_reg_target(jump_reg_target),
        .i_brjmp_target   (brjmp_target),
        .o_npc            (next_pc)
    );


    always @(posedge i_clk) begin
        if (i_reset)begin
            reg_pc <= #1 `INITIAL_PC_VALUE;//-ADDR_BYTE;
        end
        else begin
            reg_pc <= #1 next_pc;
        end
    end
endmodule