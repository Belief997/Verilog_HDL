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