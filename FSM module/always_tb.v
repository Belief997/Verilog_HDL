
`timescale 1ns/1ps
module alwa_tb;
	reg clk;
//	wire out;
	wire [3:0]cnt;
	reg  sin;
	reg sin1;

initial begin 
clk = 0;
end 
 always begin 
#5 clk = ~clk;
end

initial begin
	sin = 0;
	sin1 = 0;
	#26 sin =1;
	#25 sin =0;
	#37 sin =1;
	#16 sin =0;//sin1 = 1;
	//#9 sin1 = 0;
	#37 sin = 0;
	#56 sin1 = 1;
	#11 sin1 = 0;
end
initial begin
	#93 sin1 = 1;
	#9 sin1= 0;
end

alw the_alwa
(
	.clk(clk),.rst(0),
	.sin(sin),.sin1(sin1),
	.cnt(cnt)
);

endmodule 