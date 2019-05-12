
`timescale 1ns/1ps
module tb;
	reg clk;
	wire out;

initial clk = 1'b0;

always begin
	#2.5 clk = ~clk;
end

 top the_top (
	.clk(clk),.rst_n(1'b1),
	.out(out)

);	


endmodule 