`timescale 1ns/1ps
module tb2;
reg clk;
initial clk = 'b0;
always #5 clk = ~clk;

reg fcs, fclk;
reg [1:0] fmod;
reg [15:0] fdata;

initial begin
	fcs = 'b1;
	fclk = 'b0;
	fmod = 'b0;
	fdata = 'b0;

	#123 fcs = 'b0;
	#6 fclk = 'b1;
	fmod = 2'b01;
	fdata = 16'd6;
	#146 fclk = 'b0;
	#22 fcs = 'b1;

	#138 fcs = 'b0;
	#6 fclk = 'b1;
	fmod = 2'b11;
	fdata = 16'd7;
	#146 fclk = 'b0;
	#22 fcs = 'b1;

	#148 fcs = 'b0;
	#6 fclk = 'b1;
	fmod = 2'b10;
	fdata = 16'd8;
	#146 fclk = 'b0;
	#22 fcs = 'b1;
end


fcor the_fcor(
	.clk(clk),
	.fdata(fdata),
	.fclk(fclk), .fcs(fcs),
	.fmod(fmod)

);



endmodule 
