//tb for 74HC161
//f_CP is 100MHz
//plz set run time longer than 7000ns
`timescale 1ns/1ps
module tb_74HC161;
reg CP; initial CP = 'b0;
always #5 CP <= ~CP;

wire [3:0] D = 4'H1;
wire [3:0] Q;
reg CEP, CET, PE, CR;
wire TC;
initial begin
	CR = 1'b0;       //asy clear enabla
	CEP = 1'b1;
	CET = 1'b1;	
	PE = 1'b1;
	#53 CR = 1'b1; 	 //clear done, start count 
	#73 PE = 1'b0;   //syn set data 
	#14 PE = 1'b1;   //count, generate co(TC)
	#200 CEP = 1'b0; //CEP hold data 
	#36 CEP = 1'b1;
	#56 CET = 1'b0;  //CET hold data
	#23 CET = 1'b1;
	#46 CEP = 1'b0;	 //CEP hold data & cnter == 15 & CET == 1
	#46 CET = 1'b0;	 //CEP hold data & cnter == 15 & CET == 0
	#50 CEP = 1'b1;	 //continue cnt
	    CET = 1'b1;
end 

Counter_74HC161 the_cnter(
	.CEP(CEP),.CET(CET),.PE(PE),.CP(CP),.CR(CR),
	.D(D),
	.TC(TC),
	.Q(Q)
	);
endmodule 