
module LFSR#(
	parameter SEED = 1
)(
	input clk,
	output noise1,noise2,noise3
);

reg  [14 : 0] lfsr,lfsr_1;
reg [23:0] lfsr_2;

initial begin 
	lfsr = SEED;
	lfsr_1 = SEED;
	lfsr_2 = SEED;
end

always@(posedge clk) begin
	if(lfsr & 1)
		lfsr = (lfsr >> 1) ^ (16'hc001 >> 1);
	else
		lfsr = (lfsr >> 1);

end 

always@(posedge clk) begin
	
//		lfsr_1 ={{((lfsr_1[14])^(lfsr_1[13])),lfsr_1<<2}>>1,lfsr[14]};
	lfsr_1 ={{((lfsr_1[14])^(lfsr_1[13])),lfsr_1[12:0]},lfsr_1[14]};	
end 
always@(posedge clk) begin
	
//		lfsr_1 ={{((lfsr_1[14])^(lfsr_1[13])),lfsr_1<<2}>>1,lfsr[14]};
	lfsr_2 ={lfsr_2[23]^lfsr_2[22],lfsr_2[23]^lfsr_2[21],lfsr_2[20:17],lfsr_2[23]^lfsr_2[16],lfsr_2[15:0],lfsr_2[23]};	
end 

//assign noise = (lfsr >> 2) & 1;
assign noise1 = (lfsr >> 14) & 1;
assign noise2 = (lfsr_1 >> 14) & 1;
assign noise3 = (lfsr_2 >> 14) & 1;
endmodule 