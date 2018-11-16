`timescale 1ns/1ps
module tb;
reg clk; initial clk = 'b0;
always #5 clk <= ~clk;

reg rst_n; initial begin rst_n = 1'b0; #100 rst_n = 'b1; end
reg update; 
initial begin 
	update = 'b0;
	#200 update = 'b1;
	#20 update = 'b0;

end
reg key0; 
initial begin 
	key0 = 'b0;
	#200 key0 = 'b1;
	#2000 key0 = 'b0;

end


reg [28:0] data_5, data_4, data_3, data_2, data_1, data_0;
initial begin
	data_5 = 28'ha000_000;
	data_4 = 28'ha000_000;
	data_3 = 28'ha000_000;
	data_2 = 28'ha000_000;
	data_1 = 28'ha000_000;
	data_0 = 28'ha000_000;

end

wire CLK, DATA, LE, CE, PDBRF, MUXOUT, LD;

//adf4351 the_pll(
//	.clk(clk), .rst_n(rst_n),
//	.update(update),
//	.data_5(data_5), .data_4(data_4), .data_3(data_3), .data_2(data_2), .data_1(data_1), .data_0(data_0),
//	.CLK(CLK), .DATA(DATA), .LE(LE), .CE(CE), .PDBRF(PDBRF),
//	.MUXOUT(MUXOUT), .LD(LD)
//
//);

top the_top(
	.clk(clk),
	.CLK(CLK), .DATA(DATA), .LE(LE), .CE(CE), .PDBRF(PDBRF),
	.MUXOUT(MUXOUT), .LD(LD),
	.key0(key0)


);

endmodule 