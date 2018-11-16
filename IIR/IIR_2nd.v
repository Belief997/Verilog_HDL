//module IIR_2nd#(
//	parameter b0 = 13_044, b1 = -24_789, b2 = -2, a1 = -30_885, a2 = 16_242,
//	parameter Datain_AW = 12, Dataout_AW = 12, DataShift = 14
//)(
//	input clk, nrst,
//	input signed [Datain_AW - 1 : 0] In,
//	output signed [Dataout_AW - 1 : 0] Out
//
//);
//	wire signed [Datain_AW - 1 : 0] bx0 = ((2*Datain_AW'b1)*b0 * In) >>> DataShift;
//	wire signed [Datain_AW - 1 : 0] bx1 = (b1 * In) >>> DataShift;
//	wire signed [Datain_AW - 1 : 0] bx2 = (b2 * In) >>> DataShift;
//	wire signed [Datain_AW - 1 : 0] ay1 = (a1 * Out) >>> DataShift;
//	wire signed [Datain_AW - 1 : 0] ay2 = (a2 * Out) >>> DataShift;
//
//	reg signed [Datain_AW - 1 : 0] d;
//
//
//
//
//
//endmodule 

module IIR_2nd#(
	parameter W = 32,
	parameter FSW = 16,
	parameter real B0 = 1,
	parameter real B1 = 1,
	parameter real B2 = 1,
	parameter real A1 = 1,
	parameter real A2 = 1
)(
	input clk,en,
	input signed [W-1:0] in,
	output  signed  [W-1:0] out
);

	wire signed [W-1:0] b0 = (B0 * (2.0 ** FSW));
	wire signed [W-1:0] b1 = (B1 * (2.0 ** FSW));
	wire signed [W-1:0] b2 = (B2 * (2.0 ** FSW));
	wire signed [W-1:0] a1 = (A1 * (2.0 ** FSW));
	wire signed [W-1:0] a2 = (A2 * (2.0 ** FSW));
	wire signed [4*W-1:0] bx0L = b0 * in;
	wire signed [4*W-1:0] bx1L = b1 * in;
	wire signed [4*W-1:0] bx2L = b2 * in;
	wire signed [4*W-1:0] ay1L = a1 * out;
	wire signed [4*W-1:0] ay2L = a2 * out;
	wire signed [W-1:0] bx0 = bx0L >>> FSW;
	wire signed [W-1:0] bx1 = bx1L >>> FSW;
	wire signed [W-1:0] bx2 = bx2L >>> FSW;
	wire signed [W-1:0] ay1 = ay1L >>> FSW;
	wire signed [W-1:0] ay2 = ay2L >>> FSW;

	reg signed [W-1:0] d[0:1];
initial begin
	d[0] = 'sb0;
	d[1] = 'sb0;
end

assign out = bx0 + d[0];

always@(posedge clk) begin
	if(en)begin
		d[0] <= bx1 - ay1 + d[1];
		d[1] <= bx2 - ay2;
	end
end
endmodule 