
module top_T(
	input clk, 
	output MRST, WR, RD,  FBH, OSK,
	output UDCLK,
	output [5:0] A,
	output [7:0] D,
	output mod,
	input key0 /*, key1*/, rst_in, add_in,
	input [31:0] Freq_0, Freq_1, Freq_L_0, Freq_L_1, dFreq_0, dFreq_1

);
//initi other port
//assign UDCLK = ;
//assign FBH = 'b0;
//assign OSK = 'b0;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
wire k0, k1;
////reg [47:0] FreqWord;
////initial begin
////	FreqWord = 48'haa_55_aa_55_aa_55;
////end
//reg  [47:0] temp;//changeable output , adjust width and type   
//initial begin flag = 'b0; temp = 48'd1_407_374_883_553; end 
////always@(posedge clk)begin
////    if(k0)begin
////    if(flag != 2'd3)  flag <= flag + 2'b1;
////    else if(flag == 3'd3)   flag <= 2'd0;
////    end
////end
////always@(posedge clk) begin
////    case(flag)
////        3'd0:begin
////            temp <= 48'd938_249_922_369 ; //1M
//////                 temp <= 48'h00_77_33_aa_55_f5 ; //test
////           end
////        3'd1:begin
////            temp <= 48'd4_691_249_611_844; //5M
////           end 
////        3'd2:begin
////            temp <= 48'd938_249_922_3689; //10M
////           end
////        3'd3:begin
////            temp <= 48'd37_529_996_894_754; //40M
////           end
//////        3'd4:begin
//////            temp <= ;
//////           end  
//////        3'd5:begin
//////            temp <= ;
//////            end
////        default: begin
////            temp <= 48'd938_249_922_369;
////        end
////    endcase
////end
/////////////////////////////////////////////////////////////
//reg swep; initial swep = 'b0;
//reg [1:0] swep_dly; initial swep_dly = 'b0;
//always@(posedge clk) begin
//     swep_dly <= {swep_dly[0], swep};
//end
//wire swep_flg = (swep_dly == 2'b10) || (swep_dly == 2'b01);
//reg en; initial en = 'b0;
//always@(posedge clk)begin
// en <= k0?~en:en;
// end
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 /////////////////////////////////////////////////////////////////////////////////  sweep!!!
// always@(posedge clk)begin flag <= en; end

//reg [31:0] cnt; initial cnt = 'b0;
//always@(posedge clk)begin
//    if((cnt+1'b1) != 32'd5_000_000)begin
//        cnt <= cnt + 1'b1;
//    end
//    else cnt <= 'b0;
//end

//always@(posedge clk)begin
//    if(en)begin
//        if (((cnt + 1'b1) == 32'd5_000_000) ) 
//       temp <=(temp < 48'd56_294_995_342_131)?  (temp +  48'd1_407_374_883_553 ): 48'd1_407_374_883_553; 
////        temp <=( (temp == 48'd37_529_996_894_754) || (temp < 48'd37_529_996_894_754))? temp : 48'd938_249_922_369;
//    end
//    else begin
//        temp <= temp;
//    end
//end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

myDDS my_dds(
    .clk(clk),
    .Freq_0( Freq_0), .Freq_1(Freq_1 ), .Freq_L_0(Freq_L_0 ), .Freq_L_1(Freq_L_1 ), .dFreq_0( dFreq_0), .dFreq_1( dFreq_1),
    .rst_in(rst_in ), .add_in(add_in ),
    .key0(key0),
    .mod(mod),
    
    .MRST(MRST ), .WR( WR), .RD(RD ),  .FBH(FBH ), .OSK(OSK ),
    .UDCLK(UDCLK ),
    .A(A),
    .D(D)
    );
//AD9854 the_AD9854(
//	.clk(clk), .rst_n(1'b1),
//	.FreqWord(temp),
//	.MRST(MRST), .WR(WR), .RD(RD), .UDCLK(UDCLK),
//	.A(A),
//	.D(D) 

//);
 keys the_keys (
   .clk(clk),
   .key0(key0), .key1(/*key1*/), .key2(),
   .k0(k0), .k1(), .k2()

);
endmodule 


module myDDS(
    input clk,
    input [31:0] Freq_0, Freq_1, Freq_L_0, Freq_L_1, dFreq_0, dFreq_1,
    input rst_in, add_in,
    input key0,
    output reg mod,
    
    output MRST, WR, RD,  FBH, OSK,
    output UDCLK,
    output [5:0] A,
    output [7:0] D
    );
    //set port
    assign FBH = 'b0;
    assign OSK = 'b0;
    
    //get edge
    reg [1:0] rst_dly, add_dly; initial begin rst_dly = 'b0; add_dly = 'b0; end
    always@(posedge clk)begin
        rst_dly <= {rst_dly[0], rst_in};
        add_dly <= {add_dly[0], add_in};
    end
    wire en_rst = (rst_dly[0] ^ rst_dly[1]);
    wire en_add = (add_dly[0] ^ add_dly[1]);
    
    /////
    reg [47:0] Freq, Freq_L, dFreq;
    initial begin
        Freq = 48'd1_407_374_883_553;
    end
    
    reg [47:0] temp;
    initial temp = 48'd1_407_374_883_553;
    ///
    //reget Freq
    always@(posedge clk)begin
        Freq <= {Freq_1[15:0], Freq_0};
        Freq_L <= {Freq_L_1[15:0], Freq_L_0};
        dFreq <= {dFreq_1[15:0], dFreq_0};
    end
    
    
    //mod change
    initial mod = 'b0;
    wire k0;
    always@(posedge clk)begin
        mod <= k0? (mod + 1'b1) : mod;
    end
    
    
    always@(posedge clk)begin
        if(~mod)begin //0
            temp <= Freq;
        end else begin
            temp <= en_add ? (temp + dFreq) : en_rst ? Freq_L : temp;
        end
    end
    
    
    
    AD9854_t the_AD9854(
        .clk(clk), .rst_n(1'b1),
        .FreqWord(temp),
        .MRST(MRST), .WR(WR), .RD(RD), .UDCLK(UDCLK),
        .A(A),
        .D(D) 
    
    );
     keys the_keys (
       .clk(clk),
       .key0(key0), .key1(), .key2(),
       .k0(k0), .k1(), .k2()
    
    );
    
endmodule



