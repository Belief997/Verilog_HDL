`timescale 1ns/1ps
module tb;
	reg clk,nrst;
	wire CS,CLK,SDI; 
initial begin
	clk = 1'b0;
	nrst = 1'b1;
	#200 nrst = ~nrst;
	#15 nrst = ~nrst;
end
always begin #5 clk = ~clk;	end	

//always begin
	
//end


 top the_top(
	.clk(clk), .nrst(nrst),
	.CS(CS), .CLK(CLK), .SDI(SDI)

);

endmodule 
