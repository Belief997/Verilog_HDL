
module get_sysen(
	input clk,
	input man,
	output en, 
	output reg sys

);
	
	reg [1:0] man_dly; initial man_dly = 'b0;
	always@(posedge clk) man_dly <= {man_dly[0] , man};
	wire medge = ((man_dly == 2'b10) || (man_dly == 2'b01));

	wire [31:0] prd;
	reg [31:0] cnt; initial cnt = 'b0;
	always@(posedge clk)begin
		if(medge)begin
			cnt <= ( (cnt > (prd >> 2)) && (cnt < (prd - (prd >>2))) )? 'b0 : cnt;
		end
		else begin
			if(cnt < prd) cnt <= cnt + 1'b1;
			else cnt <= 'b0;
		end
	end

	assign en = ( (cnt == (prd >>2)) || (cnt == (prd - (prd >> 2))) );
	initial sys = 'b0;
	always@(posedge clk) begin
		if(en) sys <= ~sys;
	end


get_prd the_prd(
	.clk(clk), 
	.medge(medge),
	.prd(prd) 
);


endmodule 
