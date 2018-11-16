
module FIR_3M(
	input clk,
 	input signed [7:0] sig,
	output  signed [7:0] out_3M
);

//wire signed [15:0] out_3M_l, out_3M_h;
//FIR_lp_3M the_lp_3M
//(
//    .Clock(clk),
//    .ClkEn(1'b1),
//    .AsyncRst(1'b0),
//    .In(16'sb1*sig<<<5),
//    .Out(out_3M_l)
//);
//FIR_hp_3M the_hp_3M
//(
//    .Clock(clk),
//    .ClkEn(1'b1),
//    .AsyncRst(1'b0),
//    .In(out_3M_l),
//    .Out(out_3M_h)
//);
//assign out_3M = out_3M_h >>> 5;

//wire signed [9:0] out_3M_l;
//wire signed [10:0] out_3M_h;
//FIR_lp_3M_10 the_lp_3M
//(
//    .Clock(clk),
//    .ClkEn(1'b1),
//    .AsyncRst(1'b0),
//    .In(10'sb1*sig<<<1),
//    .Out(out_3M_l)
//);
//FIR_hp_3M_10 the_hp_3M
//(
//    .Clock(clk),
//    .ClkEn(1'b1),
//    .AsyncRst(1'b0),
//    .In(11'sb1*out_3M_l<<<1),
//    .Out(out_3M_h)
//);
//assign out_3M = out_3M_h >>> 2;

wire signed [10:0]  out_3M_h;
FIR_bp_3M_11 the_bp_3M
(
    .Clock(clk),
    .ClkEn(1'b1),
    .AsyncRst(1'b0),
    .In(11'sb1*sig<<<3),
    .Out(out_3M_h)
);
assign out_3M = out_3M_h >>> 3;
endmodule 
