
module FIR_1M(
	input clk,
 	input signed [7:0] sig,
	output  signed [7:0] out_1M
);


wire signed [7:0] out_1M_l;
FIR_lowpass_1M the_lp_1M
(
    .Clock(clk),
    .ClkEn(1'b1),
    .AsyncRst(1'b0),
    .In(sig),
    .Out(out_1M_l)
);
FIR_hp_1M the_hp_1M
(
    .Clock(clk),
    .ClkEn(1'b1),
    .AsyncRst(1'b0),
    .In(out_1M_l),
    .Out(out_1M)
);


endmodule 
