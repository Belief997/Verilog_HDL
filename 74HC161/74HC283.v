

module A_74HC283(
	  input [3:0] A, B,
	  input Cin,
	  output [3:0] Sum,
	  output Cout
	  );
	wire [4:0] sum = A + B + Cin;
	assign Sum = sum[3:0];
	assign Cout = sum[4];
//	  always@(A,B,Cin)
//		    begin:adder
//			      integer i;
//			      q[0]=Cin;
//			      for(i=0;i<=4;i=i+1)
//				        begin
//					          q[i+1]=(A[i]& B[i])|(A[i]&q[i])|( B[i]&q[i]);
//					          Sum[i]=A[i]^ B[i]^q[i];
//				        end
//			      Cout=q[4];
//		    end
endmodule

