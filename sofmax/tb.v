`timescale 1ns/1ps
module tb;
reg clk;

initial clk = 'b0;
always #5 clk <= ~clk;

reg rst_n;
initial begin
	rst_n = 'b1;
	#21 rst_n = 'b0;
	#10 rst_n = 'b1;

end

reg [31:0] x; initial x = 'b0;
initial begin
//	x = 32'hC0133333;
//	 x = 32'h40133333;
//	#15 x = 32'h41099999;
//	x = 32'h4123AE14;
	x = 32'h42A2B333;//81.35
#200 x = 32'h41099999;
end

reg signed [7:0] test = -8'sd3;
wire [6:0] ttest = ~(test[6:0]-1);


top the_top(
	.clk(clk), .rst_n(rst_n),
	.x(x)
//	output signed [33:0] z_in

);


endmodule 