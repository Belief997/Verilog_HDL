

module Bin2Bcd(
	input clk,
	input [13:0] Bin,//0~9999
	output reg [15:0] Bcd
);
	reg [13:0] BinTemp;
	reg [15:0] BcdTemp;

always@(posedge clk) begin
	/*if (BinTemp >= 17'd10000) begin  //0~99_999
		BinTemp <= BinTemp - 17'd10000;
		BcdTemp <= BcdTemp + 20'h10000;
	end
	else */if (BinTemp >= 14'd1000) begin  //0~9_999
		BinTemp <= BinTemp - 14'd1000;
		BcdTemp <= BcdTemp + 16'h1000;
	end
	else if (BinTemp >= 10'd100) begin  //0~999
		BinTemp <= BinTemp - 10'd100;
		BcdTemp <= BcdTemp + 12'h100;
	end
	else
	if (BinTemp >= 7'd10) begin
		BinTemp <= BinTemp - 7'd10;
		BcdTemp <= BcdTemp + 8'h10;
	end
	else if (BinTemp >= 7'd1) begin
		BinTemp <= BinTemp - 7'd1;
		BcdTemp <= BcdTemp + 8'h01;
	end
	else begin
		BinTemp <= Bin;
		BcdTemp <= 8'b0;
		Bcd <= BcdTemp;
	end
end 
endmodule 

module Bcd2Seg(
	input clk,
	input [3:0] Bcd,
	output reg [6:0] Seg
);
always @(posedge clk) begin
	Seg <= 
		(Bcd == 4'd0)?7'h3F:
		(Bcd == 4'd1)?7'h06:
		(Bcd == 4'd2)?7'h5B:
		(Bcd == 4'd3)?7'h4F:
		(Bcd == 4'd4)?7'h66:
		(Bcd == 4'd5)?7'h6D:
		(Bcd == 4'd6)?7'h7D:
		(Bcd == 4'd7)?7'h07:
		(Bcd == 4'd8)?7'h7F:
		(Bcd == 4'd9)?7'h6F:7'h00;

end 
endmodule 