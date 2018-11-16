
module top (
	input clk200M,
	output CS, WR, CAB,
	output [7:0] DATA

);

  wire [23:0] freq = 24'd1678;//20k
  wire [23:0] phaseShift = 'b0;
  wire [7:0] sin;





    dds #( 
	.PHASE_W (24), 
	.DATA_W (8), 
	.TABLE_AW  (12),
	.MEM_FILE  ("SineTable_unsigned_4096X8.dat")
) dds_inst (
       .FreqWord(freq),
       .PhaseShift(phaseShift),
       .clk(clk200M),
       .ClkEn(1'b1),
       .Out(sin)) ;

dac_driver the_TLS7528(
	.clk(clk200M), .nrst(1'b1),//low active
	.data_1(sin), .data_2(sin - 8'd128),
	.CS(CS), .WR(WR), .CAB(CAB),
	.DATA(DATA)
);


endmodule 