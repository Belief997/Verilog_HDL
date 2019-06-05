module comparatorGates(
	input [1:0] A, B,
	output AeqB, AgeqB, AltB
);

wire [1:0] A_NOT, B_NOT;


not not_a0(A_NOT[0], A[0]);
not not_a1(A_NOT[1], A[1]);
not not_b0(B_NOT[0], B[0]);
not not_b1(B_NOT[1], B[1]);

// AeqB
wire AeqB_00, AeqB_01, AeqB_10, AeqB_11;
and and_AeqB_00(AeqB_00, A_NOT[1], A_NOT[0], B_NOT[1], B_NOT[0]);
and and_AeqB_01(AeqB_01, A_NOT[1], A[0], B_NOT[1], B[0]);
and and_AeqB_10(AeqB_10, A[1], A_NOT[0], B[1], B_NOT[0]);
and and_AeqB_11(AeqB_11, A[1], A[0], B[1], B[0]);
or  or_AeqB(AeqB, AeqB_00, AeqB_01, AeqB_10, AeqB_11);

// AltB
wire AltB_0, AltB_1, AltB_2;
and and_AltB_0(AltB_0, A_NOT[1], B[1]);
and and_AltB_1(AltB_1, A_NOT[1], A_NOT[0], B_NOT[1], B[0]);
and and_AltB_2(AltB_2, A[1], A_NOT[0], B[1], B[0]);
or  or_AltB(AltB, AltB_0, AltB_1, AltB_2);

// AgeqB
not notAgeqB(AgeqB,AltB);

endmodule 

/*****************************************/

module comparatorExpressions(
	input [1:0] A, B,
	output AeqB, AgeqB, AltB
);

assign AeqB = (A[1] & A[0] & B[1] & B[0]) || (~A[1] & ~A[0] & ~B[1] & ~B[0]) || 
		(~A[1] & A[0] & ~B[1] & B[0]) || (A[1] & ~A[0] & B[1] & ~B[0]);
assign AgeqB = (~B[1] & ~B[0]) || (A[1] & A[0]) || (A[0] & ~B[1]) || (A[1] & ~B[1]) || (A[1] & B[1] & ~B[0]);
assign AltB = (~A[1] & B[1])||(~A[1] & ~A[0] & ~B[1] & B[0])||(A[1] & ~A[0] & B[1] & B[0]);

endmodule 

/*****************************************/

module comparatorTruthTable(
	input [1:0] A, B,
	output AeqB, AgeqB, AltB
);
wire [3:0] AB={A,B};
reg [2:0] Out = 'b0;

always@(*)begin
	case (AB)
	4'b0000: Out = 3'b110 ; 
	4'b0001: Out = 3'b001 ;
	4'b0010: Out = 3'b001 ;
	4'b0011: Out = 3'b001 ;
	4'b0100: Out = 3'b010 ;
	4'b0101: Out = 3'b110 ;
	4'b0110: Out = 3'b001 ;
	4'b0111: Out = 3'b001 ;
	4'b1000: Out = 3'b010 ;
	4'b1001: Out = 3'b010 ;
	4'b1010: Out = 3'b110 ;
	4'b1011: Out = 3'b001 ;
	4'b1100: Out = 3'b010 ;
	4'b1101: Out = 3'b010 ;
	4'b1110: Out = 3'b010 ;
	4'b1111: Out = 3'b110 ;
	endcase
end

assign AeqB = Out[2];
assign AgeqB = Out[1];
assign AltB = Out[0];
endmodule 