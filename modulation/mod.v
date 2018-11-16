module mod
(
	input clk, rst,
	input signed [9:0] c,	// ? Q1.9
	input signed [7:0] x,	// Q1.7
	input [7:0] m,			// ? Q0.8
	output reg signed [10:0] sig // Q2.9
);
	reg signed [7:0] mx;	// Q1.7, (-1,1)
	initial begin
		mx = 8'sd0;
		sig = 11'sd0;
	end
	wire signed [8:0] sm = m;	// Q1.8
	//               1.7   1.8  1.7
	//wire signed [7:0] mx = (17'sd1 * sm * x) >>> 8;

	always@(posedge clk) begin
		if(~rst)
			mx <= (17'sd1 * sm * x) >>> 8;
		else
			mx <= 8'sd0;
	end
	//            Q2.7(0,2)   Q1.7(-1,1)  Q2.7(1)
	wire signed [8:0] mx_shift = mx + (9'sd1 <<< 7);
	always@(posedge clk) begin
	// Q2.9(-2,2)      Q2.7(0,2)   Q1.9(-1,1)
		sig <= (19'sd1 * mx_shift   *   c) >>> 7;
	end
endmodule




