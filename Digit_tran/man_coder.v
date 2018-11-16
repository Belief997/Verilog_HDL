//delay half T
//1:1->0  0:0->1
module man_coder(
	input clk,
	input en0, en1,
	input in,
	output reg out
);
	initial out = 'b0;
	always@(posedge clk)begin// in ^ clk
		if(en0) out <= ~in;// in ^ 1 
		else if(en1) out <= in;// in ^ 0
		else out <= out; 
	end

//	always@(posedge en0 or posedge en1)begin
//		if(en0) out <= ~in;// in ^ 1 
//		if(en1) out <= in;// in ^ 0		
//	end

endmodule 