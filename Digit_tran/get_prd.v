
module get_prd(
	input clk, 
	input medge,
	output reg [31:0] prd 
);
	reg [31:0] cnt100ms;	initial cnt100ms = 'b0;
	wire en100ms = (cnt100ms == 32'd9_999_999);
	always@(posedge clk)begin
		if(cnt100ms < 32'd9_999_999) cnt100ms <= cnt100ms + 1'b1;
		else cnt100ms <= 'b0;
	end

	reg [31:0] p_cnt, p_temp;
	initial begin prd = 'b0; p_cnt = 'b0; p_temp = 'b0; end
	always@(posedge clk)begin
		if(medge) p_cnt <= 'b0;
		else p_cnt <= p_cnt + 1'b1;
	end

	always@(posedge clk)begin
		if(en100ms) begin
			prd <= p_temp;
			p_temp <= 'b0;
		end
		else if(medge) p_temp <= ((p_cnt > p_temp)? p_cnt : p_temp);
		 
	end


endmodule 
