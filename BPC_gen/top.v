
module top(
	input clk, rst_n,
	output out
);



bpc_gen the_bpc_gen(
	.clk(clk), .rst_n(rst_n),
	.bpc(out)
);

endmodule

