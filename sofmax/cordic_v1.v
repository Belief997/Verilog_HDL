
module cordic(
	input clk, rst_n,
	input signed [31:0] z_in,
	output signed [33:0] cosh, sinh, e

);
 	parameter PPL = 16; 
	parameter K = 32'h351B_2449 ;
	parameter P = 32'h4D20_F45F;//1/K , *2^30

//integer i;
reg  [31:0] angle[18:0];
initial begin
	angle[0] = 32'h464F_A9EB >>1 ;//0.549306144334055, 1/2, tanh
	angle[1] = 32'h20B1_5DF5 >>1 ;//
	angle[2] = 32'h1015_891D >>1 ;//
	angle[3] = 32'h802_AC45 >>1 ;//
//	angle[4] = 32'h802_AC45 >>1 ;//
	angle[4] = 32'h400_5562 >>1 ;//
	angle[5] = 32'h200_0AAB >>1 ;//
	angle[6] = 32'h100_0155 >>1 ;//
	angle[7] = 32'h80_002B >>1 ;//
	angle[8] = 32'h40_0005 >>1 ;//
	angle[9] = 32'h20_0001 >>1 ;//
	angle[10] = 32'h10_0000 >>1 ;//
	angle[11] = 32'h8_0000 >>1 ;//
//	angle[13] = 32'h4_0000 >>1 ;//
	angle[12] = 32'h4_0000 >>1 ;//
	angle[13] = 32'h2_0000 >>1 ;//
	angle[14] = 32'h1_0000 >>1 ;//
	angle[15] = 32'h8000 >>1 ;//
	angle[16] = 32'h4000 >>1 ;//
	angle[17] = 32'h2000 >>1 ;//
	angle[18] = 32'h1000 >>1 ;//
	angle[19] = 32'h800 >>1 ;//

end

reg signed [31:0] x[20:0], y[20:0], z[20:0], s[19:0];
//reg s[18:0]
initial begin x[0] = P; y[0] = 'b0;  s[0] = 32'sb1;  end

reg [6:0] i;
always@(posedge clk or negedge rst_n)begin
//	z[0] = z_in;
	if(!rst_n)begin
		for(i=1;i<=20;i=i+1)begin
			x[i] <= 'b0;
			y[i] <= 'b0;
			z[i] <= 'b0;
			s[i] <= 'b0;
		end
	end		
	else begin
//		i <= 'b0;
		for(i=0;i<=20;i=i+1)begin
			if(i==0) z[0] = z_in;
			else if(z[i-1][31])begin
			x[i] <= x[i - 1] - ( y[i - 1] >>> (i ));
			y[i] <= y[i - 1] - (x[i - 1] >>> (i ));
			z[i] <= z[i - 1] + angle[i - 1];		
			end
			else begin
			x[i] <= x[i - 1] + ( y[i - 1] >>> (i ));
			y[i] <= y[i - 1] + (x[i - 1] >>> (i ));
			z[i] <= z[i - 1] - angle[i - 1];	
//			end


//			else begin
//			x[i] <= x[i - 1] +  ((z[i - 1][31] )? -32'sb1 : 32'sb1) * (y[i - 1] >>> i );  // must right move with sign   >>>  
//			y[i] <= y[i - 1] +  ((z[i - 1][31])? -32'sb1 : 32'sb1) * (x[i - 1] >>> i );
//			z[i] <= z[i - 1] - ((z[i - 1][31])? -32'sb1 : 32'sb1) * angle[i - 1];
//			s[i] <= (z[i] > 0)? 32'sb1 : -32'sb1;



//			x[i] <= x[i - 1] + (s[i - 1] * y[i - 1]) >>> (i - 1);
//			y[i] <= y[i - 1] + (s[i - 1] * x[i - 1]) >>> (i - 1);
//			z[i] <= z[i - 1] - s[i - 1] * angle[i - 1];
//			s[i] <= (z[i] > 0)? 32'sb1 : -32'sb1;
			end
		end
	end
end

assign cosh = x[20];
assign sinh = y[20];
assign e = cosh + sinh;



endmodule 