
//module Shift_add_0#( 
//parameter N = 1, parameter Y = 0
//)(
//	input clk, rst_n,
//	input signed [45:0] x_in, y_in,
//	output reg [45:0] x_out, y_out
//);
//	initial begin y_out = 'b1 <<< 23; x_out = 'b0; end
//	always@(posedge clk)begin
//	    if(~rst_n)begin
//		x_out <= 'b0;
//		y_out <= 'b1;
//	    end else begin
//		if((x_in + N) <= 46'sb0)begin
//			x_out <= x_in + N;
//			y_out <= y_in - (y_in >>> Y);
//		end 
//		else begin
//			x_out <= x_in;
//			y_out <= y_in;
//		end 
//	    end
//	end
//endmodule 
