

module S_74HC194(
//	input L,
	input [1:0] S,	      //?????S[1]:S1 S[0]:S0
	input CR_n, CP,        //???????
	input DS,             //????DS[1]:Dsl DS[0]:Dsr
	input [3:0] D,        //????
	output [3:0] Q    //????
	);
	reg [3:0] q; initial q = 'b0;
	always@(posedge CP)
	if(~CR_n) q <= 4'b0;
	else
		case(S)
		2'b00: q <= q;
		2'b01: q <= {DS, Q[3:1]}; //shift right
		2'b10: q <= {Q[2:0], DS}; //shift left
		2'b11: q <= D;
		default: q <= q;
		endcase
	assign Q = CR_n? q : 4'b0;

endmodule
