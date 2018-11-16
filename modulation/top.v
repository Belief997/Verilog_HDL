module top(
	input clk,
	input [7:0] m,			// ? Q0.8
	output wire signed [10:0] sig 

);

	wire [9:0] c;
	wire [7:0] x;

carr the_c(
	.clk(clk),
	.c(c)
);

siggen the_sig(
	.clk(clk),
	.x(x)
);

mod the_mod(
	.clk(clk), .rst(1'b0),
	.c(c),	// ? Q1.9
	.x(x),	// Q1.7
	.m(m),			// ? Q0.8
	.sig(sig) // Q2.9
);
endmodule 
