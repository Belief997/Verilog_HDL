
module comparatorBehavior4bits(
	input [3:0] A, B,
	output AeqB, AgeqB, AltB
);

assign AeqB = (A == B);
assign AgeqB = (A >= B);
assign AltB = (A < B);

endmodule 