`timescale 1ns/1ps
module tb_HW1_FSM;
 reg clk, rst_n;

 initial begin
	clk = 'b0;
	rst_n = 'b1;
 end
	
// generate clk 125M 
always #4 clk <=  ~clk;

reg X;
wire Z_1, Z_2;

initial begin
         X = 'b0; rst_n = 'b0;
    #100 rst_n = 'b1;     
	#17 X = 0;
	#17 X = 1;	
	#17 X = 0;
	#19 X = 0;
	#17 X = 1;
	#17 X = 0;
	#17 X = 0;
	#17 X = 1;
	#17 X = 1;
	#17 X = 0;
	#17 X = 1;
	#17 X = 0;
	#17 X = 0;
	#17 X = 1;
	#17 X = 0;
	#17 X = 1;
	#17 X = 0;
	#17 X = 0;
	#17 X = 1;
	#17 X = 1;

         rst_n = 'b0;
	#17 X = 0;
	#17 X = 1;	
	#17 X = 0;
	#19 X = 0;
	#17 X = 1;
	#17 X = 0;
	#17 X = 0;
	#17 X = 1;
	#17 X = 1;
	#15 rst_n = 'b1;
	#17 X = 0;
	#17 X = 1;
	#17 X = 0;
	#17 X = 0;
	#17 X = 1;
	#17 X = 0;
	#17 X = 1;
	#17 X = 0;
	#17 X = 0;
	#17 X = 1;
	#17 X = 1;




end

HW1_FSM_4 the_fsm_1 (
	.clk(clk), .rst_n(rst_n),
	.X(X),
	.Z(Z_1)
);

HW1_FSM_8 the_fsm_2 (
	.clk(clk), .rst_n(rst_n),
	.X(X),
	.Z(Z_2)
);
endmodule 
