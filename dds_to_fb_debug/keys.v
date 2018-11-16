module keys (	input wire key0,key1,key2,key3,key4,key5,
		output wire k0,k1,k2,k3,k4,k5,
		input wire clk
);
	reg [19:0] cnt_10ms;
	initial cnt_10ms = 20'b0;

	always@(posedge clk) begin		
			if(cnt_10ms < 20'd1000) cnt_10ms <= cnt_10ms + 20'b1;//20'd1000_000
			else cnt_10ms <= 20'b0;
	end

	reg key_0_smp, key_1_smp,key_2_smp, key_3_smp,key_4_smp, key_5_smp;
	initial begin
	key_0_smp = 0;
	key_1_smp = 0;
	key_2_smp = 0;
	key_3_smp = 0;
	key_4_smp = 0; 
	key_5_smp = 0;
	end

	always@(posedge clk) begin
		if(cnt_10ms == 20'd000) begin
			key_0_smp <= key0;
			key_1_smp <= key1;
			key_2_smp <= key2;
			key_3_smp <= key3;
			key_4_smp <= key4;
			key_5_smp <= key5;
		end
	end

	reg k0_dly, k1_dly,k2_dly, k3_dly,k4_dly, k5_dly;
	always@(posedge clk) begin
		k0_dly = key_0_smp;
		k1_dly <= key_1_smp;
		k2_dly <= key_2_smp;
		k3_dly <= key_3_smp;
		k4_dly <= key_4_smp;
		k5_dly <= key_5_smp;
		
	end

	assign k0= ({key_0_smp, k0_dly} == 2'b10);
	assign k1= ({key_1_smp, k1_dly} == 2'b10);
	assign k2= ({key_2_smp, k2_dly} == 2'b10);
	assign k3= ({key_3_smp, k3_dly} == 2'b10);
	assign k4= ({key_4_smp, k4_dly} == 2'b10);
	assign k5= ({key_5_smp, k5_dly} == 2'b10);


/*
always begin
	 k0= ({key_0_smp, k0_dly} == 2'b10);
	 k1= ({key_1_smp, k1_dly} == 2'b10);
	 k2= ({key_2_smp, k2_dly} == 2'b10);
	 k3= ({key_3_smp, k3_dly} == 2'b10);
	 k4= ({key_4_smp, k4_dly} == 2'b10);
	 k5= ({key_5_smp, k5_dly} == 2'b10);
end
*/

endmodule
