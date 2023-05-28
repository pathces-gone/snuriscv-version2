`timescale 1ns / 1ps

module tb_snuriscv;
reg 	clk;
reg 	clock_en;
reg     reset;

always
    #10 clk = ~clk;
 
initial begin
    reset       <= 0;
    clk     	<= 0;
	clock_en	<= 0;
# 50
    reset       <= 1;
# 100
	clock_en	<= 1;
# 100
	clock_en	<= 0;
# 100
$finish;
end

// Read From Front-end Interface


// Run module
snurisc DUT(
    .i_reset            (reset),
    .i_clk				(clk		),
    .i_clock_en			(clock_en	)
);

// Write to Back-end Interface

endmodule
