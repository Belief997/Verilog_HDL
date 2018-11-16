module carr(
	input clk,
	output reg signed [9:0] c
);
	initial c = 10'sd0;
	reg [10:0] acc; initial acc = 11'd0;
	always@(posedge clk) begin
		if(acc < 11'd1980)
			acc <= acc + 11'd20;
		else
			acc <= 11'd0;
	end
	always@(posedge clk) begin
		if(acc < 11'd1000)
			c <= acc - 11'd500;
		else
			c <= 11'd1500 - acc;
	end
endmodule
