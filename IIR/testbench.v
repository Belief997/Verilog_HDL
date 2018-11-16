
`timescale 1ns/1ps
module tb;
	reg clk;//,en;
	wire signed [11:0] in;//12 or 16
	wire unsigned [15:0] out;

//initial begin clk = 1'b0; en = 1'b0; end 
initial begin clk = 1'b0;end
always begin #500_000 clk = ~clk;	end
//always begin 	#1200_000 en = 1'b1; end

//wire freq = 24'd1678;//10k
//wire freq = 24'd8;//50

//wire signed [31:0] the_in = 2'sb1 * in;
//wire signed [11:0] iir_out;
//assign out = iir_out + 12'sd4096;

// my_iir the_iir(
//	.clk(clk),//.en(en),
//	.in(the_in),
//	.out(out)
//
//);
//
    dds #( 
	.PHASE_W (24), 
	.DATA_W (12), 
	.TABLE_AW  (8),
	.MEM_FILE  ("SineTable_signed_256X12.dat")
) dds_inst (
       .FreqWord(24'd838_861),//24'd838_861  Fs1k Fout 49.9hz
       .PhaseShift(24'b0),
       .clk(clk),
       .ClkEn(1'b1),
       .Out(in)) ;


top the_top(
	.clk(clk),
	.in(in),
	.out(out)

);


endmodule 