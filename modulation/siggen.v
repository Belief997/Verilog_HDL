
module siggen(
	input clk,
	output reg signed [7:0] x
);
	initial x = 8'sd0;
    //        Q2.22(-2,2)
	reg signed [23:0] pacc; initial pacc = 24'sd0;
	always@(posedge clk) begin
		if(pacc < 24'sh7F_8000)		
			pacc <= pacc + 24'sd6698;
		else
			pacc <= -24'sh7F_8000;
	end

	//             Q1.7(-1,1) Q2.22(-2,2)  Q2.22(1.0)
	wire signed [7:0] yrise = (pacc + (24'sd1 <<< 22)) >>> 15;
//                 Q1.7(-1,1) Q2.22(1.0)  Q2.22(-2,2)
	wire signed [7:0] yfall = ((24'sd1 <<< 22) - pacc) >>> 15;
	always@(posedge clk) begin
		if(pacc < 24'sd0)
			x <= yrise;
		else
			x <= yfall;
	end

endmodule 