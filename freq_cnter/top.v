
module top(
	input clk200M,
	input x, y,
	output reg [31:0] xyr_reg, xyh_reg, xyl_reg,
	output reg [31:0] x_reg, r_reg, xh_reg, xl_reg

);

	wire PreGate;
	reg [1:0] g_delay;
	always@(posedge clk200M) begin
		g_delay <= {g_delay[0], PreGate};
	end
	wire g_rise = (g_delay == 2'b01);

	
	wire [31:0] xyr_count, xyh_count, xyl_count;
	wire [31:0] x_count, r_count, xh_count, xl_count;

	initial begin
		xyr_reg = 'b0; xyh_reg = 'b0; xyl_reg = 'b0;
		x_reg = 'b0; r_reg = 'b0; xh_reg = 'b0; xl_reg = 'b0;
	end

	always@(posedge clk200M) begin
		if(g_rise)begin
			xyr_reg <= xyr_count;
 			xyh_reg <= xyh_count; 
			xyl_reg <= xyl_count;
			x_reg <= x_count;
 			r_reg <= r_count; 
			xh_reg <= xh_count; 
			xl_reg <= xl_count;
		end
		else begin
			xyr_reg <= xyr_reg;
 			xyh_reg <= xyh_reg; 
			xyl_reg <= xyl_reg;
			x_reg <= x_reg;
 			r_reg <= r_reg; 
			xh_reg <= xh_reg; 
			xl_reg <= xl_reg;
		end

	end





gate the_gate(
	.clk200M(clk200M), .rst_n(1'b1),
	.PreGate(PreGate)
);

 Freq_metr the_Freq(
	.clk(clk200M), .rst_n(1'b1),
	.x(x),  .gate(PreGate),
	.x_count(x_count), .r_count(r_count), .xh_count(xh_count), .xl_count(xl_count)


);

//200M shift to 800M
 Duty_400M the_Duty_400M(
	.clk100M(clk200M),
	.x(x), .y(y), .gate(PreGate),
	.xyr_count(xyr_count),.xyh_count(xyh_count), .xyl_count(xyl_count)

);
endmodule 