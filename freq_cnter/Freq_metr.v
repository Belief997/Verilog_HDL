//refer to loywong
//x : freq, period, duty(h&l cnt)
module Freq_metr(
	input clk, rst_n,
	input x,
	input gate,
	output reg [31:0] x_count, r_count, xh_count, xl_count//200M 28bit->268M

);
	reg [1:0] x_delay, y_delay;
	always@(posedge clk) begin
		x_delay <= {x_delay[0], x};
	end
	wire x_rise = (x_delay == 2'b01);
	wire x_fall = {x_delay == 2'b10};

	reg [1:0] g_sync;
	always@(posedge clk)begin
		if(x_rise)
		g_sync <= {g_sync[0], gate};
	end
	wire g_rise = (g_sync == 2'b01);
	wire g_fall = (g_sync == 2'b10);

	reg [31:0] x_cnt;
	initial begin x_count = 'b0; x_cnt = 'b0;end
	always@(posedge clk) begin
		if(g_rise)	x_cnt <= 28'b0;
		else if(g_fall)	x_count <= x_cnt + 1'b1;
		else if(x_rise) x_cnt <= x_cnt + 1'b1;
		else		x_cnt <= x_cnt;
	end
	
	reg [31:0] r_cnt;
	initial begin r_count = 'b0; r_cnt = 'b0; end
	always@(posedge clk) begin
		if(g_rise)	r_cnt <= 28'b0;
		else if(g_fall)	r_count <= r_cnt;
		else 	 	r_cnt <= r_cnt + 1'b1;
	end

	reg [31:0] xh_cnt;
	initial begin xh_count = 'b0; xh_cnt = 'b0; end
	always@(posedge clk) begin
		if(g_rise)	xh_cnt <= 28'b0;
		else if(g_fall)	xh_count <= xh_cnt;
		else if(x) 	xh_cnt <= xh_cnt + 1'b1;
		else 		xh_cnt <= xh_cnt;
	end

	reg [31:0] xl_cnt;
	initial begin xl_count = 'b0; xl_cnt = 'b0; end
	always@(posedge clk) begin
		if(g_rise)	xl_cnt <= 28'b0;
		else if(g_fall)	xl_count <= xl_cnt;
		else if(!x) 	xl_cnt <= xl_cnt + 1'b1;
		else 		xl_cnt <= xl_cnt;
	end




endmodule 
