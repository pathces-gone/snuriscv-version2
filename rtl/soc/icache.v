/*
* Module : icache
* Author : Evan.Park
* Date   : May 29, 2023
* Description: This module implements the functionality of instruction cache.
*/
`timescale 1ns / 1ps
`include "../common/definitions.vh"

module icache
#(
    parameter WIDTH = 32,
    parameter LOG2_MEM_SIZE = 10,
    parameter MEM_SIZE = 2<<LOG2_MEM_SIZE
)
(
    input i_reset,
    input i_clk,
    input i_mem_rq,
    input i_rnw,
    input [WIDTH-1:0] i_pc,
    inout [WIDTH-1:0] i_data
);

`ifndef CONFIGURE_SYNTHESIS
    reg  [WIDTH-1:0]        mem [MEM_SIZE-1:0];
    wire [LOG2_MEM_SIZE:0]  index;

    assign index = i_pc>>2;
    assign data  = (i_mem_rq & i_rnw) ? mem[index]: 32'hx;

    // Reference : ${workspace}/ref_c/README.md
    always @(posedge i_clk) begin
        if(i_reset) begin
            mem[ 0] <= #1 {7'b0000000,5'b01000,5'b00000,3'b000,5'b00001,`I_FORMAT}; 
            mem[ 1] <= #1 {7'b0000000,5'b00000,5'b00001,3'b000,5'b00011,`I2_FORMAT};
            mem[ 2] <= #1 {7'b0000000,5'b00100,5'b00000,3'b000,5'b00001,`I_FORMAT}; 
            mem[ 3] <= #1 {7'b0000000,5'b00011,5'b00000,3'b000,5'b00100,`S_FORMAT}; 
            mem[ 4] <= #1 {7'b0000000,5'b00000,5'b00001,3'b000,5'b00100,`I2_FORMAT};
            mem[ 5] <= #1 {7'b0000000,5'b00000,5'b00000,3'b000,5'b00000,`I_FORMAT};
            mem[ 6] <= #1 {7'b0000000,5'b00100,5'b00000,3'b000,5'b00001,`I_FORMAT}; 
            mem[ 7] <= #1 {7'b0000000,5'b00100,5'b00000,3'b000,5'b00010,`I_FORMAT}; 
            mem[ 8] <= #1 {7'b0010000,5'b00010,5'b00001,3'b000,5'b00000,`SB_FORMAT};
            mem[ 9] <= #1 {32'h0};
            mem[10] <= #1 {32'h0};
            mem[11] <= #1 {32'h0};
            mem[72] <= #1 {7'b0000000,5'b01111,5'b00000,3'b000,5'b00011,`I_FORMAT}; 
        end
        else begin
            if(i_mem_rq & !i_rnw) mem[index] <= i_data;        
        end
    end
`else
    // FPGA
`endif

endmodule