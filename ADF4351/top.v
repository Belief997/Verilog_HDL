
module top(
	input clk,
	output CLK, DATA, LE, CE, PDBRF,
	input MUXOUT, LD,
	input key0


);
	wire k0;
	reg update; initial update = 1'b0;
	reg [28:0] data_5, data_4, data_3, data_2, data_1, data_0;
	initial begin 
	data_5 = 32'h0058_0000 >> 3;	
	data_4 = ((32'h0080_0038| (32'b110 << 20)) | (32'd160 << 12)) >> 3;
	data_3 = (32'h00e4_0000 | (32'd160 << 3)) >> 3;	
	data_2 = (32'h0000_21c0 | (32'b1 << 14)) >> 3;
	data_1 = (32'h0000_8010 ) >> 3;
	data_0 = ((32'h0000_0000 | (32'd16_384 << 15)) | (32'b0 << 3)) >> 3;
	end

	always@(posedge clk)begin
		update <= k0? ~update : update;
	end


adf4351 the_pll(
	.clk(clk), .rst_n(1'b1),
	.update(update),
	.data_5(data_5), .data_4(data_4), .data_3(data_3), .data_2(data_2), .data_1(data_1), .data_0(data_0),
	.CLK(CLK), .DATA(DATA), .LE(LE), .CE(CE), .PDBRF(PDBRF),
	.MUXOUT(MUXOUT), .LD(LD)

);
key the_key(
	.clk(clk),
	.key0(key0), .key1(), .key2(),
	.k0(k0), .k1(), .k2()

);
endmodule 

