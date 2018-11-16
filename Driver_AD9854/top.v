
module top_0(
	input clk, 
	output MRST, WR, RD,
	output [5:0] A,
	output [7:0] D 

);




reg [47:0] FreqWord;
initial begin
	FreqWord = 48'haa_55_aa_55_aa_55;
end


AD9854 the_AD9854(
	.clk(clk), .rst_n(1'b1),
	.FreqWord(FreqWord),
	.MRST(MRST), .WR(WR), .RD(RD),
	.A(A),
	.D(D) 

);

endmodule 