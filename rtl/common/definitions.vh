// Opcode
`define R_FORMAT  7'b0110011
`define I_FORMAT  7'b0010011
`define I2_FORMAT 7'b0000011
`define S_FORMAT  7'b0100011
`define SB_FORMAT 7'b1001011
`define U_FORMAT  7'b1100111
`define J_FORMAT  7'b1101111

// Cache
`define STATE_SUCCESS 2'b1
`define STATE_FAIL    2'b0

// ALU
`define FN_ADD  2'b0010  
`define FN_SUB  2'b0110
`define FN_AND  2'b0000
`define FN_OR   2`b0001