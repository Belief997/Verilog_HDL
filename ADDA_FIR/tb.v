`timescale 1ns/1ps
module tb;
reg clk; initial clk = 'b0;
always #5 clk <= ~clk;

//reg [31:0] cnt50; initial cnt50 = 'b0;
//always@(posedge clk)begin
//	if(cnt50 < 32'd49)  cnt50 <= cnt50 + 1'b1;
//	else cnt50 <= 'b0;	
//
//end
//wire co = (cnt50 == 32'd49);

reg  [7:0] sig; initial sig = 'b0;
always begin
	#500 sig <= 8'd200;
	#500 sig <= 8'b0;
end
wire signed [7:0] out_1M, out_3M, out_1M_l;
wire signed [15:0] out_3M_l, out_3M_h;




//wire signed [7:0] sin;
//wire [23:0] freq = 24'd503_316;//d503_316 3M /838_860 5M /1678 10k /  167_772 1M
//    dds #( 
//	.PHASE_W (24), 
//	.DATA_W (8), 
//	.TABLE_AW  (12),
//	.MEM_FILE  ("SineTable_signed_4096X8.dat")
//) dds_inst (
//       .FreqWord(freq),
//       .PhaseShift(24'd0),
//       .clk(clk),
//       .ClkEn(1'b1),
//       .Out(sin)) ;

 top the_top(
	.clk(clk),
 	.sig(sig),
	.out_1M(out_1M),
	.out_3M(out_3M)//,
//	.out_1M_l(out_1M_l),
//	.out_3M_l(out_3M_l),
//	.out_3M_h(out_3M_h)
);

endmodule 