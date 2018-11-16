
module top(
	input clk,
	input clk_125M//,

//	output reg [7:]	
);

//wire [31:0] freq_0 = 32'd429_496_730;   //10M
//wire [31:0] freq_1 = 32'd343_597_384;//32'd429_496_730;

wire [31:0] freq_0 = 32'd429_496_7;//30;//100k
//wire [31:0] freq_1 = 32'd343_597_4;//84;//100k

//wire [31:0] freq_0 = 32'd429_496_73;   //1M
wire [31:0] freq_1 = 32'd343_597_38;

wire [31:0] phaseShift = 'b0;
wire signed [7:0] sin_0,sin_1;

//cnt 10k
///////////////////////////////////
reg [31:0] cnt_10k; initial cnt_10k = 'b0;
always@(posedge clk)begin
	if(cnt_10k < 32'd9_999) cnt_10k <= cnt_10k + 1'b1;
	else cnt_10k <= 'b0;
end
wire en_10k = (cnt_10k == 32'd9_999);
//////////////////////////////////////////////
//psk, ask
/////////////////////////////////////////////////////
wire [7:0] sig_sk;
reg signed [7:0] out_psk, out_ask;
always@(posedge clk)begin
	out_ask <= sig_sk[0]? sin_0 : 8'b0;
	out_psk <= sig_sk[0]? (-8'sd1 * sin_0) : sin_0; 

end
/////////////////////////////////////////////////////
//mod am
////////////////////////////////////////////////////
wire [31:0] freq_am = 32'd429_50; //32'd429_50;//1k
wire signed [7:0] sin_am;
reg [15:0] m =16'b111_1111_1111_1111;//H4000;//b111_1111_1111_1111;// 8'b1111_1111;// mQn x * 2^(n-1)
wire signed [7:0] out_am;

/////////////////////////////////////////////////////
reg [31:0] k_max;initial k_max = 32'b0;// 32'd429_497;//d214_748 //5k
wire [31:0] out_kc;
wire signed [7:0] sin_fm;


    dds #( 
	.PHASE_W (32), 
	.DATA_W (8), 
	.TABLE_AW  (12),
	.MEM_FILE  ("SineTable_signed_4096X8.dat")
) dds_0 (
       .FreqWord(freq_0),
       .PhaseShift(phaseShift),
       .clk(clk),
       .ClkEn(1'b1),
       .Out(sin_0)) ;

    dds #( 
	.PHASE_W (32), 
	.DATA_W (8), 
	.TABLE_AW  (12),
	.MEM_FILE  ("SineTable_signed_4096X8.dat")
) dds_1 (
       .FreqWord(freq_1),
       .PhaseShift(phaseShift),
       .clk(clk_125M),
       .ClkEn(1'b1),
       .Out(sin_1)) ;





//mod 1k
    dds #( 
	.PHASE_W (32), 
	.DATA_W (8), 
	.TABLE_AW  (12),
	.MEM_FILE  ("SineTable_signed_4096X8.dat")
) dds_am (
       .FreqWord(freq_am),
       .PhaseShift(phaseShift),
       .clk(clk),
       .ClkEn(1'b1),
       .Out(sin_am)) ;
///////////////////////////////////////
//LFSR the_10kbps(
//	.clk(clk), .en(en_10k),
//	.out(sig_sk)
//);
LFSR the_10kbps(
	.clk(clk), .clken(en_10k),
	.lfsr(sig_sk)
);
//////////////////////////////////////////
AM_mod the_am_mod(
	.clk(clk), .rst_n(1'b1),
	.c(sin_0),	// ? Q1.6
	.x(sin_am),	// Q1.7
	.m(m),			// ? Q0.8
	.sig(out_am) // Q2.6
);
//////////////////////////////////////////////
FM_mod the_fm_mod(
	.clk(clk), .rst_n(1'b1),
	.x(sin_am),     //Q1.7
	.k_max(k_max),	  //Q32.0
	.kc(freq_0),	  //Q32.0
	.out_kc(out_kc)	  //Q32.0
);
    dds #( 
	.PHASE_W (32), 
	.DATA_W (8), 
	.TABLE_AW  (12),
	.MEM_FILE  ("SineTable_signed_4096X8.dat")
) dds_fm (
       .FreqWord(out_kc),
       .PhaseShift(phaseShift),
       .clk(clk),
       .ClkEn(1'b1),
       .Out(sin_fm)) ;

endmodule 