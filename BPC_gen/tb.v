
`timescale 1ns/1ps
module tb;
	reg clk;
	wire out;
	wire out_n;

initial clk = 1'b0;

always begin
	#5 clk = ~clk;
end

 top the_top (
	.clk(clk),.rst_n(1'b1),
	.out(out), .out_n(out_n)

);	


endmodule 