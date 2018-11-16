
module get_jmr_dp(
	input clk, rst_n,
	input signed [15:0] x,
	input signed [7:0] x_shift,
	output reg [31:0] m,
	output reg [4:0] j,
	output reg [31:0] r
	
);
	localparam C1 = 32'H5C551D95;  //32bit dp 25 Q7.25
	localparam C2 = 32'H2C5C85FE;  //32bit dp 35 Q.35

	wire signed [47:0] xC1 = x * C1;
	reg [46:0] xC1_0;initial xC1_0 = 'b0;
	reg signed [7:0] shift_0;initial shift_0 = 'b0;
	always@(posedge clk)begin
		if(!rst_n) begin
		 	xC1_0 = 'b0;
			shift_0 = 'b0;
		end
		else begin
			xC1_0 <= (xC1[47])? (~(xC1[46:0]-1'b1)): xC1[46:0];
			shift_0 <= x_shift + 8'sd35;
		end
	end

	reg [47:0] xC1_1;initial xC1_1 = 'b0;
	reg signed [7:0] shift_1; initial shift_1 = 'b0;
	reg [31:0] m_1; initial m_1 = 'b0; 
	reg [4:0] j_1;  initial j_1 = 'b0;
	always@(posedge clk)begin
		if(!rst_n)begin
			xC1_1 = 'b0;
			shift_1 = 'b0;
		end
		else begin
			xC1_1 <= xC1_0;
			shift_1 <= shift_0;
			if(shift_1 >= -8'd5) m_1 <= xC1_1 >> (shift_1 + 5);
			else m_1 <= xC1_1 << ((~(shift_1[6:0]-1'b1))-5);
			if((shift_1 <= -8'd5) ) j_1 <= 'b0;
			else j_1 <= ({xC1_1, 5'b0} >> (shift_1 + 5))+1'b1&({xC1_1, 5'b0} >> (shift_1 + 4));   



		end
	end


	always@(posedge clk)begin
		m <= m_1;
		j <= j_1;
		r <= 'b0;
	end








endmodule 