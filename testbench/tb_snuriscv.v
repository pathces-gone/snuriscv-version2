`timescale 1ns / 1ps

module tb_snuriscv;
reg clk;
reg clock_en;
reg reset;

always
    #10 clk = ~clk;
 
initial begin
    reset<= 0;
    clk<= 0;
    clock_en<= 0;
# 50
    reset<= 1;
# 100
    clock_en<= 1;
# 100
    clock_en<= 0;
# 100
$finish;
end


// (1) Read From Front-end Interface   : mem or trace?
//     * runmodel ->Init:: I$, D$-> Run::DUT


// (2) Run Core
//     * read/write I$ and D$
snurisc Core(
    .i_reset(reset),
    .i_clk(clk),
    .i_clock_en(clock_en)
);

// (3) Write to Back-end Interface     : mem or trace ?
//     * Run::DUT -> result trace compare 

endmodule
