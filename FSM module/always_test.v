module alw
(
	input clk,rst,
	input sin,sin1,
	output reg [3:0] cnt
);

initial cnt = 4'b0;


always @(sin or posedge sin1) begin 
	if(rst) cnt <= 4'b0;
	else cnt <= cnt + 1;
end 

endmodule 