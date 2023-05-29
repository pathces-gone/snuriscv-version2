/*
* Module : snurisc_top
* Author : Evan.Park
* Date   : May 29, 2023
* Description: This module is snurisc-top module, which is System-on-chip
*              fabricating I$, D$, snurisc-core, ... 
*/
`timescale 1ns / 1ps

module snurisc
#(
    parameter AWIDTH=32,
    parameter DWIDTH=AWIDTH,
    parameter ADDR_BYTE=AWIDTH>>3
)
(
    input i_clk,
    input i_reset
);

`ifndef CONFIGURE_DEBUG_FRONTEND
    wire frontend_alu_not_taken;
    wire frontend_icache_rnw;
    wire frontend_icache_rq;
    wire [DWIDTH-1:0] frontend_rq_inst;
`else
    reg frontend_alu_not_taken;
    reg frontend_icache_rnw;
    reg frontend_icache_rq;
    reg [DWIDTH-1:0] frontend_rq_inst;
    always@(*) begin
        frontend_alu_not_taken = 1;
        frontend_icache_rnw    = 0;
        frontend_icache_rq     = 1;
        frontend_rq_inst       = 0;
    end
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
        .o_inst          (o_inst)
    );

    // 2. sunrisc_core

endmodule