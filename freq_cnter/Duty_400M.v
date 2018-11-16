
module Duty_400M(
	input clk100M, 
	input x, y, gate,
	output reg [31:0] xyr_count, xyh_count, xyl_count

);

	reg [1:0] x_delay, y_delay;
	always@(posedge clk100M) begin
		x_delay <= {x_delay[0], x};
		y_delay <= {y_delay[0], y};
	end
	wire x_rise = (x_delay == 2'b01);
	wire x_fall = {x_delay == 2'b10};
	wire y_rise = {y_delay == 2'b01};

	reg xy; initial xy = 'b0;
	always@(posedge clk100M) begin
		if(x_rise) xy <= 1'b1;
		else if(y_rise) xy <= 1'b0;
		else xy <= xy;
	end

	reg [1:0] g_sync;
	always@(posedge xy)begin
//		if(x_rise)
		g_sync <= {g_sync[0], gate};
	end
	wire g_rise = (g_sync == 2'b01);
	wire g_fall = (g_sync == 2'b10);

	reg [31:0] r_cnt;
	initial begin xyr_count = 'b0; r_cnt = 'b0; end
	always@(posedge clk100M) begin
		if(g_rise)	r_cnt <= 28'b0;
		else if(g_fall)	xyr_count <= r_cnt;
		else 	 	r_cnt <= r_cnt + 1'b1;
	end

	reg [31:0] xyh_cnt;
	initial begin xyh_count = 'b0; xyh_cnt = 'b0; end
	always@(posedge clk100M) begin
		if(g_rise)	xyh_cnt <= 28'b0;
		else if(g_fall)	xyh_count <= xyh_cnt;
		else if(xy) 	xyh_cnt <= xyh_cnt + 1'b1;
		else 		xyh_cnt <= xyh_cnt;
	end

	reg [31:0] xyl_cnt;
	initial begin xyl_count = 'b0; xyl_cnt = 'b0; end
	always@(posedge clk100M) begin
		if(g_rise)	xyl_cnt <= 28'b0;
		else if(g_fall)	xyl_count <= xyl_cnt;
		else if(!xy) 	xyl_cnt <= xyl_cnt + 1'b1;
		else 		xyl_cnt <= xyl_cnt;
	end

endmodule 