
module top(
	input clk, nrst,
	output aCS, aSCLK,
	input aSDO,
	output  [15:0] adata
);



 adc_driver the_ads7883(
	.clk(clk), .nrst(nrst),//low active
	.CS(aCS), .SCLK(aSCLK),
	.SDO(aSDO),
	.data(adata)

);
endmodule 