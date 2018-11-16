`timescale 1ns/1ps
module tb;
	reg clk;
	reg [31:0] Frq0, Frq1, Frq2, Frq3;
	reg [15:0] Phase0, Phase1, Phase2, Phase3;
	reg [23:0] Amp0, Amp1, Amp2, Amp3;
	wire SCLK, CS, PWD, RST, UP, SD0, SD1, SD2, SD3, P0, P1, P2, P3;
	
initial clk = 'b0;
always #5 clk <= ~clk;

initial begin
	Frq0 = 32'hb000_a5a5; Frq1 = 32'hb000_a5a5; Frq2 = 32'hb000_a5a5;Frq3 = 32'hb000_a5a5;
	Phase0 = 16'ha5a5; Phase1 = 16'ha5a5;Phase2 = 16'ha5a5;Phase3 = 16'ha5a5;
	Amp0 = 24'b0; Amp1 = 24'b0;Amp2 = 24'b0;Amp3 = 24'b0;
	#3635 Phase3 = 16'ha5a6;
end





top the_top(
	.clk(clk),
	.SCLK(SCLK), .CS(CS), .PWD(PWD), .RST(RST), .UP(UP),
	.SD0(SD0), .SD1(SD1), .SD2(SD2), .SD3(SD3),
	.P0(P0), .P1(P1), .P2(P2), .P3(P3)
);

endmodule 