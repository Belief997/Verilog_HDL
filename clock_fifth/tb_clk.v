`timescale 1ns/1ps
module tb;
	reg clk,rst;
	reg keyHr, keyMin, keySec;
	wire [6:0] hrSegL, hrSegH, minSegL, minSegH, secSegL, secSegH;

initial begin
	clk = 1'b0;
	keyMin = 0;
	rst = 1'b1;
	#20 rst = 1'b0;
end		

always begin	#0.05 clk = ~clk;
end 

always  begin
	#90 keyMin = 0;
	#5555 keyMin = 1;
	#6 keyMin = 0;
	#6 keyMin = 1;
	#7 keyMin = 0;
	#9 keyMin = 1;
	#1 keyMin = 0;
end

top_clk the_top(
	.clk,.rst,
	.keyHr(0), .keyMin(0/*keyMin*/), .keySec(0),
	.hrSegL, .hrSegH, .minSegL, .minSegH, .secSegL, .secSegH
);

endmodule 