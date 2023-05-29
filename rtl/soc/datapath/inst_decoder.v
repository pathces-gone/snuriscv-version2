/*
* Module : inst_decoder
* Author : Evan.Park
* Date   : May 29, 2023
* Description: This module implements the functionality of inst_decoder
*/
module inst_decoder #(
    parameter DWIDTH=32
) (
    input  [DWIDTH-1:0] i_inst,
    output [ 6:0]       o_opcode,
    output [ 4:0]       o_rs2,
    output [ 4:0]       o_rs1,
    output [ 2:0]       o_funct3,
    output [ 4:0]       o_rd,
    output [ 6:0]       o_r_funct7,
    output [11:0]       o_i_imm,
    output [ 6:0]       o_s_imm_h,
    output [ 4:0]       o_s_imm_l,
    output [ 6:0]       o_sb_imm_h,
    output [ 4:0]       o_sb_imm_l
);
    //Common
    assign o_rs2      = i_inst[24:20];
    assign o_rs1      = i_inst[19:15];
    assign o_funct3   = i_inst[14:12];
    assign o_rd       = i_inst[11:7];
    opcode_decoder opcode_decoder_m1(
        .i_inst(i_inst),
        .o_opcode(o_opcode),
    );
    
    // R type
    assign o_r_funct7 = i_inst[31:25];

    // I type
    assign o_i_imm    = i_inst[31:20];

    // S type
    assign o_s_imm_h  = i_inst[31:25];
    assign o_s_imm_l  = i_inst[11:7];

    // SB type
    assign o_sb_imm_h = i_inst[31:25];
    assign o_sb_imm_l = i_inst[11:7];
endmodule