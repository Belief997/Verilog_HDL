
module tb;
	reg clk;
	wire CS, SCLK, SDO;
	wire [15:0] data;

initial begin 
clk = 1'b0;
end
 assign SDO = 1'b1;
always begin 
	#5 clk <= ~clk;
end


 top the_ads7883(
	.clk(clk), .nrst(1'b1),//low active
	.aCS(CS), .aSCLK(SCLK),
	.aSDO(SDO),
	.adata(data)

);



endmodule 