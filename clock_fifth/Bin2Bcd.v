module Bin2Bcd(
	input clk,
	input [6:0] Bin,//0~99
	output reg [7:0] Bcd
);
	reg [6:0] BinTemp;
	reg [7:0] BcdTemp;

always@(posedge clk) begin
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