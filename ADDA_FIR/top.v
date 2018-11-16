
module top(
	input clk,
 	input  [7:0] sig,
	output  signed [7:0] out_1M, out_3M//, out_1M_l,
//	output signed [15:0] out_3M_l, out_3M_h
);


 FIR_1M the_1M(
	.clk(clk),
 	.sig(sig-8'd128),
	.out_1M(out_1M)
);

FIR_3M the_3M(
	.clk(clk),
 	.sig(sig-8'd128),
	.out_3M(out_3M)
);


endmodule 