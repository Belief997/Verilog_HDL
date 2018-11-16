
module top(
	input clk,
	output noise1,noise2,noise3,
//	output reg [11:0] out,
	output [11:0] out,
	output [11:0] Seg
//	output [13:0] freq
);
wire [13:0] freq;
////dds to iir module
wire [11:0] square;
//reg [24:0]cnt4; wire co;
//initial begin cnt4= 'b0; end
//always @(posedge clk)begin
//    if(cnt4 < (25'd25_000_000-1'b1)) cnt4<=cnt4+1'b1;
//    else cnt4 <= 25'd0;
//end
//assign co = (cnt4 == (25'd25_000_000 - 1'b1));
//
//reg [24:0]cntclk;wire coclk;
//initial begin cntclk= 'b0; end
//always @(posedge clk)begin
//    if(cntclk < (25'd25_00-1'b1)) cntclk<=cntclk+1'b1;
//    else cntclk <= 25'd0;
//end
//assign coclk = (cntclk == (25'd25_00 - 1'b1));
//
//reg signed [31:0] the_in;
//wire [31:0] the_out;
//initial begin the_in = 32'sb0;out = 'b0; end
//always@(posedge clk)begin
//	the_in <= (32'sb1 * dds)<<<6;
//	out <= the_out >>>6;
//end
//

////display module
//reg [5:0] cntdelay;//1s 28
//reg [13:0] cntdata;
//initial begin cntdata = 'b0; cntdelay = 'b0; end
//always@(posedge clk)begin
//	cntdelay <= cntdelay + 1'b1;
//end
//always@(posedge clk)begin
//	if(cntdelay == 6'd6)
//	cntdata <= cntdata +1'b1;
//	else	cntdata <= cntdata;
//end
//

//get max ,min ,differ module



//LFSR#(
//	.WITH(15)//, 
//	//.SEED(2**WITH) 
//)the_LFSR(
//	.clk(clk),
//	.noise1(noise1),
//	.noise2(noise2),
//	.noise3(noise3)
//);

//my_iir iir(
//	.clk(co),
//	.in(the_in),
//	.out(the_out)
//
//);
    dds #( 
	.PHASE_W (12), 
	.DATA_W (12), 
	.TABLE_AW  (8),
	.MEM_FILE  ("SineTable_unsigned_256X12.dat")
) dds_inst (
       .FreqWord( 12'd167),//208 0.5Hz NO react,
       .PhaseShift(12'b0),
       .clk(clk),
       .ClkEn(1'b1),
       .Out(square)) ;

//display the_display(
//	.clk(clk),
//	.data(13'd1*cntdata),
//	.Seg(Seg)
//);

//max_min the_max_min(
//	.clk(clk),
//	.data(dds),
//	.out(out) 
//);

FreMeasure the_freq(  
	.clk(clk),  
	.rst_n(1'b1),  
	.Sig_in(square[11]),  
	.Fre(freq) 
);

endmodule 