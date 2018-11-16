module top(
	input clk, rst,
	input signed [11:0] m0,
	input key1, key2 ,key3, key4, key5, key6, key7, key0,
	output  pwm 
);
	wire signed [7:0] out1, Out;
	reg [31:0] Freq, FreqShift;
	wire [31:0] FreqWord = Freq + FreqShift;// 32'd1678;
	wire k0, k1, k2, k3, k4, k5, k6, k7;
	reg signed [11:0] mShift;
	wire signed [11:0] m = m0 + mShift;

initial begin
	Freq = 32'd214_748;
	FreqShift = 32'b0;
	mShift = 12'sb0;
end
always@(posedge k0) begin//k0--
	if(k2)//1k
	FreqShift <= FreqShift - 32'd42_950;
	else if(k3)//100
	FreqShift <= FreqShift - 32'd4_295;
	else//10
	FreqShift <= FreqShift - 32'd429;
end
always@(posedge k1) begin//k1++
	if(k2)//1k
	FreqShift <= FreqShift + 32'd42_950;
	else if(k3)//100
	FreqShift <= FreqShift + 32'd4_295;
	else//10
	FreqShift <= FreqShift + 32'd429_50;
end

always@(posedge k6 or posedge k7) begin
	if(k6) mShift <= mShift - 12'sd204;
	else mShift <= mShift + 12'sd204;
end

dds #( 
	.PHASE_W(32), 
	.DATA_W(8), 
	.TABLE_AW (8),
	.MEM_FILE ("SineTable8X8.dat")
)the_dds( 
	.FreqWord(FreqWord), 
	.PhaseShift(32'b0),
	.clk(clk), 
	.ClkEn(1'b1), 
	.Out(out1)
) ;

keys the_keys1(
	.clk(clk),
	.key0(key1),.key1(key2),.key2(key3),
	.k0(k1),.k1(k2),.k2(k3)

);
keys the_keys2(
	.clk(clk),
	.key0(key4),.key1(key5),.key2(key6),
	.k0(k4),.k1(k5),.k2(k6)

);

keys the_keys3(
	.clk(clk),
	.key0(key7),.key1(key0),.key2(1'b0),
	.k0(k7),.k1(k0),.k2()

);

range_mod the_mod (
	.clk(clk), .rst(rst),
	.m(m), //Q1.11   (-1,1)
	.in(out1),//Q1.7
	.out(Out) //Q1.7
);

PWM the_pwm( 
	.clk(clk), .rst(1'b0), 
	.data(8'sd0), .in(Out),
	.pwm(pwm)
);

endmodule 
