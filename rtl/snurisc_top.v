/*
* Module : snurisc_top
* Author : Evan.Park
* Date   : May 29, 2023
* Description: This module is snurisc-top module, which is System-on-chip
*              fabricating I$, D$, snurisc-core, ... 
*/
`timescale 1ns / 1ps

module snurisc_top
#(
    parameter AWIDTH=32,
    parameter DWIDTH=AWIDTH,
    parameter ADDR_BYTE=AWIDTH>>3
)
(
    input i_clk,
    input i_reset
);

    wire frontend_alu_not_taken;
    wire frontend_icache_rnw;
    wire frontend_icache_rq;
    wire [DWIDTH-1:0] frontend_rq_inst;
    wire [DWIDTH-1:0] inst_fetched;

`ifdef CONFIGURE_DEBUG_FRONTEND
    assign   frontend_alu_not_taken = 1'b1;
    assign   frontend_icache_rnw    = 1'b1;
    assign   frontend_icache_rq     = 1'b1;
    assign   frontend_rq_inst       = 32'b0;
`endif

    // 1. Frontend 
    frontend frontend_m0
    (
        .i_clk           (i_clk),
        .i_reset         (i_reset),
        .i_alu_not_taken (frontend_alu_not_taken),
        .i_icache_rnw    (frontend_icache_rnw),
        .i_icache_rq     (frontend_icache_rq),
        .i_inst          (frontend_rq_inst),
        .o_inst          (inst_fetched)
    );

    // 2. sunrisc_core

endmodule