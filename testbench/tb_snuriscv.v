`timescale 1ns / 1ps

module tb_snuriscv;
reg clk;
reg reset;

always
    #5 clk = ~clk;
 
initial begin
    reset<= 1;
    clk<= 0;
# 50
    reset<= 0;
# 1000
$finish;
end


// (1) Read From Front-end Interface   : mem or trace?
//     * runmodel ->Init:: I$, D$-> Run::DUT


// (2) Run Core
//     * read/write I$ and D$
snurisc_top DUT(
    .i_reset(reset),
    .i_clk(clk)
);

// (3) Write to Back-end Interface     : mem or trace ?
//     * Run::DUT -> result trace compare 

endmodule
