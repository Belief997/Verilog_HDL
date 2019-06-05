`timescale 1ns/1ps
module p3hwlTestFixture;
reg [1:0] A,B;

wire AeqBgates ,AgeqBgates, AltBgates ;
wire AeqBexpressions ,AgeqBexpressions, AltBexpressions ;
wire AeqBTruthTable ,AgeqBTruthTable, AltBTruthTable ;

initial begin
	A = 0; B = 0; #7;
	A = 0; B = 1; #7;
	A = 0; B = 2; #7;
	A = 0; B = 3; #7;
	A = 1; B = 0; #7;
	A = 1; B = 1; #7;
	A = 1; B = 2; #7;
	A = 1; B = 3; #7;
	A = 2; B = 0; #7;
	A = 2; B = 1; #7;
	A = 2; B = 2; #7;
	A = 2; B = 3; #7;
	A = 3; B = 0; #7;
	A = 3; B = 1; #7;
	A = 3; B = 2; #7;
	A = 3; B = 3; #7;

end

comparatorGates the_gate(
	A, B,
	AeqBgates, AgeqBgates, AltBgates
);

comparatorExpressions the_expressions(
	A, B,
	AeqBexpressions, AgeqBexpressions, AltBexpressions
);

comparatorTruthTable the_TruthTable(
	A, B,
	AeqBTruthTable, AgeqBTruthTable, AltBTruthTable
);

endmodule
