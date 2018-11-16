`timescale 1ns/1ps
module tb;
	reg clk;
	wire unsigned [15:0] out;


initial clk = 'b0;
always  #5 clk <= ~clk;

 top the_top(
	.clk(clk),
	.out(out)
);



endmodule 