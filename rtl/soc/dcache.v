/*
* Module : dcache
* Author : Evan.Park
* Date   : May 29, 2023
* Description: This module implements the functionality of data cache.
*/
`timescale 1ns / 1ps
`include "../common/definitions.vh"

module dcache 
#(
    parameter AWIDTH = 32,
    parameter DWIDTH = 32,
    parameter LOG2_MEM_SIZE = 8,
    parameter MEM_SIZE = 2<<LOG2_MEM_SIZE
)
(
    input              i_reset,
    input              i_clk,
    input              i_enable,
    input              i_rnw,
    input [AWIDTH-1:0] i_addr,
    input [DWIDTH-1:0] i_wdata,
    output[DWIDTH-1:0] o_rdata,
    output             o_status
);

`ifndef CONFIGURE_SYNTHESIS
    reg  [DWIDTH-1:0] mem [MEM_SIZE-1:0];
    wire [LOG2_MEM_SIZE:0] index;

    assign o_status= `STATE_SUCCESS; //its not real-case.
    assign index   = i_addr>>2;
    assign rdata   = (i_enable & i_rnw) ? mem[index]: 32'hx;

    always @(posedge i_clk) begin
        if(i_reset) begin
            mem[ 0] <= #1 {32'hffff};
            mem[ 1] <= #1 {32'habcd};
            mem[ 2] <= #1 {32'h2222};
            mem[ 3] <= #1 {32'hfdfd};
            mem[ 4] <= #1 {32'h1111};
            mem[ 5] <= #1 {32'h3333};
            mem[ 6] <= #1 {32'h4444};
            mem[ 7] <= #1 {32'h7777};
            mem[ 8] <= #1 {32'h8888};
            mem[ 9] <= #1 {32'h9999};
            mem[10] <= #1 {32'h0};
            mem[11] <= #1 {32'h0};
        end 
        else begin
            if(i_enable & !i_rnw) mem[index] <= i_wdata;
        end
    end

    `ifdef CONFIGURE_DEBUG
        // Debug wire
        wire [DWIDTH-1:0] db_r0 = mem[0];
        wire [DWIDTH-1:0] db_r1 = mem[1];
        wire [DWIDTH-1:0] db_r2 = mem[2];
        wire [DWIDTH-1:0] db_r3 = mem[3];
        wire [DWIDTH-1:0] db_r4 = mem[4];
    `endif
`else
    // FPGA
`endif

endmodule