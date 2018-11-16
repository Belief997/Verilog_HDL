
`default_nettype none
module top(
    input wire clk,sdi,
    output reg sclk,cs,sdo
);
    wire signed[8:0] sampler_cnt;
    wire start;
    Counter #(262)samcnt(clk, 1'b0, 1'b1,sampler_cnt, start);//381.6793893kHz Sample Rate Serial Device (260T)
	assign sdo = 1'b1;
    reg unsigned[15:0] data;
    wire busy;
	  ADS8865 #(.HBDIV(4),.BITS(16)) the_ads8865 (clk, 1'b0, start,sdi,busy,sclk, cs, data);
endmodule
