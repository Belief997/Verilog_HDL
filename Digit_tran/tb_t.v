`timescale 1ns/1ps
module tb_t;
reg clk;
initial clk = 'b0;
always #5 clk <= clk;

wire sig, noise, man, en0, clock;


top_t the_top_t(
	.clk(clk),
	.sig(sig), .noise(noise), 
	.man(man), .en0(en0),
	.clock(clock)
);






endmodule 