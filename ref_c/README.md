# RISC-V Instruction Table

```
OPCODE:
R type: 0110011
    add     rd rs1 rs2 31..25=0  14..12=0 6..2=0x0C 1..0=3
    sub     rd rs1 rs2 31..25=32 14..12=0 6..2=0x0C 1..0=3
    sll     rd rs1 rs2 31..25=0  14..12=1 6..2=0x0C 1..0=3
    slt     rd rs1 rs2 31..25=0  14..12=2 6..2=0x0C 1..0=3
    sltu    rd rs1 rs2 31..25=0  14..12=3 6..2=0x0C 1..0=3
    xor     rd rs1 rs2 31..25=0  14..12=4 6..2=0x0C 1..0=3
    srl     rd rs1 rs2 31..25=0  14..12=5 6..2=0x0C 1..0=3
    sra     rd rs1 rs2 31..25=32 14..12=5 6..2=0x0C 1..0=3
    or      rd rs1 rs2 31..25=0  14..12=6 6..2=0x0C 1..0=3
    and     rd rs1 rs2 31..25=0  14..12=7 6..2=0x0C 1..0=3
I type: 00100 11
    addi    rd rs1 imm12           14..12=0 6..2=0x04 1..0=3
    slli    rd rs1 31..26=0  shamt 14..12=1 6..2=0x04 1..0=3
    slti    rd rs1 imm12           14..12=2 6..2=0x04 1..0=3
    sltiu   rd rs1 imm12           14..12=3 6..2=0x04 1..0=3
    xori    rd rs1 imm12           14..12=4 6..2=0x04 1..0=3
    srli    rd rs1 31..26=0  shamt 14..12=5 6..2=0x04 1..0=3
    srai    rd rs1 31..26=16 shamt 14..12=5 6..2=0x04 1..0=3
    ori     rd rs1 imm12           14..12=6 6..2=0x04 1..0=3
    andi    rd rs1 imm12           14..12=7 6..2=0x04 1..0=3
I type2: 00000 11
    lb      rd rs1       imm12 14..12=0 6..2=0x00 1..0=3
    lh      rd rs1       imm12 14..12=1 6..2=0x00 1..0=3
    lw      rd rs1       imm12 14..12=2 6..2=0x00 1..0=3
    lbu     rd rs1       imm12 14..12=4 6..2=0x00 1..0=3
    lhu     rd rs1       imm12 14..12=5 6..2=0x00 1..0=3
S type: 01000 11
    sb     imm12hi rs1 rs2 imm12lo 14..12=0 6..2=0x08 1..0=3
    sh     imm12hi rs1 rs2 imm12lo 14..12=1 6..2=0x08 1..0=3
    sw     imm12hi rs1 rs2 imm12lo 14..12=2 6..2=0x08 1..0=3
SB type: 11000 11
    beq     bimm12hi rs1 rs2 bimm12lo 14..12=0 6..2=0x18 1..0=3
    bne     bimm12hi rs1 rs2 bimm12lo 14..12=1 6..2=0x18 1..0=3
    blt     bimm12hi rs1 rs2 bimm12lo 14..12=4 6..2=0x18 1..0=3
    bge     bimm12hi rs1 rs2 bimm12lo 14..12=5 6..2=0x18 1..0=3
    bltu    bimm12hi rs1 rs2 bimm12lo 14..12=6 6..2=0x18 1..0=3
    bgeu    bimm12hi rs1 rs2 bimm12lo 14..12=7 6..2=0x18 1..0=3
U type:
    jal     rd jimm20                          6..2=0x1b 1..0=3
J type:
    jalr    rd rs1 imm12              14..12=0 6..2=0x19 1..0=3    
```


# Preset A:

## Scenario
```c
 0: addi t1, zero  ,8
 1: lw   t3, 0(t1)       //t3=0x2222
 2: addi t1, zero  ,4
 3: sw   t3, 4(t0)
 4: lw   t4, 0(t1)
 5: nop
 6: addi t1, zero ,4
 7: addi t2, zero ,4
 8: beq  t1, t2   ,256
       .
       .
       .
72: addi t3, zero, 0xf
```

## Memeory Code
```
mem[0]  <= #1 {7'b0000000,5'b01000,5'b00000,3'b000,5'b00001,`I_FORMAT}; 
mem[1]  <= #1 {7'b0000000,5'b00000,5'b00001,3'b000,5'b00011,`I2_FORMAT};
mem[2]  <= #1 {7'b0000000,5'b00100,5'b00000,3'b000,5'b00001,`I_FORMAT}; 
mem[3]  <= #1 {7'b0000000,5'b00011,5'b00000,3'b000,5'b00100,`S_FORMAT}; 
mem[4]  <= #1 {7'b0000000,5'b00000,5'b00001,3'b000,5'b00100,`I2_FORMAT};
mem[5]  <= #1 {7'b0000000,5'b00000,5'b00000,3'b000,5'b00000,`I_FORMAT};
mem[6]  <= #1 {7'b0000000,5'b00100,5'b00000,3'b000,5'b00001,`I_FORMAT}; 
mem[7]  <= #1 {7'b0000000,5'b00100,5'b00000,3'b000,5'b00010,`I_FORMAT}; 
mem[8]  <= #1 {7'b0010000,5'b00010,5'b00001,3'b000,5'b00000,`SB_FORMAT};
mem[9]  <= #1 {32'h0};
mem[10] <= #1 {32'h0};
mem[11] <= #1 {32'h0};
mem[72] <= #1 {7'b0000000,5'b01111,5'b00000,3'b000,5'b00011,`I_FORMAT}; 
```