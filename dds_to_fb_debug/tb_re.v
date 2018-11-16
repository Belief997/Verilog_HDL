/*
`timescale 1ns/1ps
module tb_re;
	reg clk;
	wire key0,key1,key2,key3,key4,key5;
    	wire   out_1;
 	wire   out_3;
 	wire   out_5;
	wire k0,k1,k2,k3,k4,k5;

    reg [23:0] freq;
    reg [23:0] freq_3;
    reg [23:0] freq_5;

initial  begin 
clk = 1'b0;
 
  		freq = 24'd1678;
		freq_3 = 24'd5033;
		freq_5 = 24'd8390;
end


always begin
#5 clk = ~clk;
end



	dds_to_fb the_fb(
        		.FreqWord(freq),
			.FreqWord_3(freq_3),
			.FreqWord_5(freq_5),
      			.Clock(clk),
       			.Out_1(out_1),
			.Out_3(out_3),
			.Out_5(out_5),
			.k0(k0),
			.k1(k1),
			.k2(k2),
			.k3(k3),
			.k4(k4),
			.k5(k5)

);

	keys the_keys(	
			.key0(key0),
			.key1(key1),
			.key2(key2),
			.key3(key3),
			.key4(key4),
			.key5(key5),
			.k0(k0),
			.k1(k1),
			.k2(k2),
			.k3(k3),
			.k4(k4),
			.k5(k5),
			.clk(clk)
);

endmodule*/


`timescale 1ns/1ps
module tb_re;
	reg clk;
	reg key0,key1,key2,key3,key4,key5;
    	wire   out_1;
 	wire   out_3;
 	wire   out_5;


initial  begin 
clk = 1'b0;
 key0 = 0;
 key1 = 0;
 key2 = 0;
 key3 = 0;
 key4 = 0;
 key5 = 0;
end


always begin
#5 clk = ~clk;

end

always begin
#9999 key1 = 1;
#500 key1 = 0 ;
#250 key1 = 1 ;
#780 key1 = 0;
#880 key1 = 1;
#9900 key1 = 0;
end
top the_top(	.clk,
	.key0,.key1,.key2,.key3,.key4,.key5,
	.out_1,
	.out_3,
	.out_5

);	
//wire [11:0] FIR_out;
//wire signed [11:0] in = out_1? 12'd1000:-12'd1000;
//FIR_Hamming_100Taps_LP_0d020 the_fir(
//    	.Clock(clk), 
//	.ClkEn(1'b1), 
//	.AsyncRst(0),
//    	.In(in),
//   	.Out(FIR_out));
//
endmodule 