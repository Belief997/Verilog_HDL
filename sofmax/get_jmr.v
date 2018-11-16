
module get_jmr(
	input clk, rst_n,
	input [31:0] x,
	output reg [28:0]  m,
	output reg [4:0] j,
	output reg [17:0] r
);
	localparam C1 = 32'h4238_AA3B;  //float
	localparam C2 = 18'd5678;       //C2 * 2**18  dp
 //	localparam C2 = 32'h3CB1_7210;
//	localparam C2 = 23'd181704;     // C2 * 2**23
	

wire [31:0] xC1;
wire signed [7:0] pow = (xC1[30:23] - 8'd127);
//reg [28:0] m; initial m = 'b0;
//reg [28:0] m_temp;// always@(posedge clk) m_temp = {1'b1, xC1[22:0], 5'b0};
wire [32:0] m_temp = {5'b1, xC1[22:0], 5'b0};

//get_m
always@(posedge clk)begin
	if(pow < 8'sd3) m <= 0;
	else if (pow < 8'sd29)  m <= (m_temp >> (8'd33 - pow));//[28:(8'd32-pow)];
	else m <= 0;
end
//get_j
always@(posedge clk)begin
	if((pow < 8'd0) || (pow > 8'd27)) j <= 'b0;
	else j <= (m_temp >> (8'd28 - pow));//[(8'd32 - pow) : (8'd27 - pow)];
end
//get_r
reg [17:0] r_temp; initial r_temp = 'b0;
always@(posedge clk)begin
	if(pow < 8'd11) begin 
		r_temp <= (m_temp >> (8'sd10 - pow)) ;
		r <= ((37'b1 * r_temp * C2) >> 18);
	end
	else begin
		r_temp <=  (m_temp << (pow - 8'sd10));
		r <= ((37'b1 * r_temp * C2) >> 18);	
	end
end



fpmul mul_XC1(  
    .mdat1(x),  
    .mdat2(C1),  
    .odat(xC1),  
    .clk(clk),  
    .rst_n(1'b1)  
  
);  


endmodule 
