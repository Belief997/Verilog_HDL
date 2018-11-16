
module get_maxmin(
	input clk, sys,
	input datain,
	output reg [7:0] up, down, mid,
	output reg [7:0] diff

);
	reg [1:0] sys_dly; initial sys_dly = 'b0;
	always@(posedge clk) sys_dly <= {sys_dly[0] , sys};
	wire clkup = (sys_dly == 2'b10); 
	wire clkdn = (sys_dly == 2'b01);

	wire [7:0] max0, min0, max1, min1, max_temp, min_temp, mid_temp;
	initial begin
		up <= 'b0;
		down <= 'b0;
		mid <= 8'd122;
		diff <= 'd0;//up - dn  min - max
		max_temp = 'b0;
		min_temp = 8'd255;
		mid_temp = 'b0;
	end

	reg [31:0] cnt; initial cnt = 'b0;
	always@(posedge clk)begin//50ms
		if(cnt < 32'd4_999_999) cnt <= cnt + 1'b1;
		else cnt <= 'b0;
	end
	wire update = (cnt == 32'd4_999_999); 


	always@(posedge clk)begin
		if(clkup | clkdn)begin
			if((max0 > max1) && (min0 > max1))//0H 1L
				mid_temp <= (min0 + max1) >> 1;
			else if((max1 > max0) && (min1 > max0))//0L 1H
				mid_temp <= (min1 + max0) >> 1;
			
		end
	end

	always@(posedge clk)begin
		if(clkup)begin//0 update
			if((min0 > mid_temp) && (max0 > mid_temp)) // H
				min_temp <= (min0 < min_temp)? min0 : min_temp;
			else if((min0 < mid_temp) && (max0 < mid_temp))// L
				max_temp <= (max0 > max_temp)? max0 : max_temp;
		end
		else if(clkdn)begin//1 update
			if((min1 > mid_temp) && (max1 > mid_temp)) // H
				min_temp <= (min1 < min_temp)? min1 : min_temp;
			else if((min1 < mid_temp) && (max1 < mid_temp))// L
				max_temp <= (max1 > max_temp)? max1 : max_temp;
		end
	end

	always@(posedge clk)begin
		if(update)begin
			up <= min_temp;
			down <= max_temp;
			mid <= mid_temp;
			diff <= min_temp - max_temp;
		end
		else begin
			up <= up;
			down <= down;
			mid <= mid;
			diff <= diff ;
		end
	end




FIFO_cycle the_fifo0(
	.clk(clk),
	.datain(datain),
	.en0(clkup), .en1(clkdn),
//	output [7:0] dataout,
	.max(max0), .min(min0)

);

FIFO_cycle the_fifo1(
	.clk(clk),
	.datain(datain),
	.en0(clkdn), .en1(clkup),
//	output [7:0] dataout,
	.max(max1), .min(min1)

);
endmodule 
