// fc_out = sin_fm * delta_f_max + fc0
module FM_mod #(parameter W = 32)(
	input clk, rst_n,
	input signed [7:0] x,     //Q1.7
	input [W-1 : 0] k_max,	  //Q32.0
	input [W-1 : 0] kc,	  //Q32.0
	output reg [W-1 : 0] out_kc	  //Q32.0
);
	wire signed [W:0] sk_max = k_max; //Q33.0
	reg signed [W-1:0] f_shift;initial f_shift = 'b0;
	always@(posedge clk)begin
		if(~rst_n)	f_shift <= 'b0;
		else 	f_shift <= (41'sb1 * x * sk_max) >>> 7;
	end

	initial out_kc = 'b0;
	always@(posedge clk)begin
		if(~rst_n) out_kc <= kc;
		else out_kc <= kc + f_shift;

	end


endmodule 