
module top(input wire clk,
	input wire key0,key1,key2,key3,key4,key5,
    output     out_1,
  output     out_3,
  output     out_5

);								

    reg [23:0] freq;
    reg [23:0] freq_3;
    reg [23:0] freq_5;

    reg [23:0] freq_M;
    reg [23:0] freq_3M;
    reg [23:0] freq_5M;


	wire k0,k1,k2,k3,k4,k5;


 	initial begin

  		freq = 24'd1678;
		freq_3 = 24'd5033;
		freq_5 = 24'd8390;

//  		freq_M = 24'd167_772;
//
//
//		freq_3M = 24'd503_315;
//
//
//		freq_5M = 24'd838_860;
	end
	

	/*dds_to_fb the_fb(
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

);*/

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
	dds_to_fb the_fb_HIGH(
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
endmodule 

