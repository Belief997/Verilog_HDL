`timescale 1ns/1ps
module tb;
reg clk; initial clk = 'b0;
always #5 clk <= ~clk;

reg clk_125M;initial clk_125M = 'b0;
always #4 clk_125M <= ~clk_125M;


reg [5:0] flag_mod;
reg [31:0] freq_c;
wire [7:0] out, mod_m;
wire mod_sk;

initial freq_c = 32'd429_496_73;

initial begin
	   flag_mod = 'b0;
	#1000 flag_mod = 6'b10_1010;
	#999999 flag_mod = 6'b11_0000;
	#560000 flag_mod = 6'b11_0001;
end


 Sine_gen the_sin(
	.clk(clk),
	.flag_mod(flag_mod),
	.freq_c(freq_c),
	.out(out), 
	.mod_m(mod_m),
	.mod_sk(mod_sk)

);





//top the_top(
//	.clk(clk),
//	.clk_125M(clk_125M)
//);

endmodule 