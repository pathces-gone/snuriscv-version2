/*
* Module : opcode_decoder
* Author : Evan.Park
* Date   : May 29, 2023
* Description: This module implements the functionality of opcode_decoder
*/
module opcode_decoder #(
    parameter DWIDTH=32
) (
    input  [DWIDTH-1:0] i_inst,
    output [ 6:0]       o_opcode
);
    //Common
    assign o_opcode   = i_inst[6:0];
endmodule