
module  FreMeasure(  
    input                           clk,  
    input                           rst_n,  //low active
    input                           Sig_in,  
    output              [13:0] Fre  
);  
parameter T_1s = 28'd49_999_999;  
/***********????**********///??????????????2??????????????????????????  
reg [27:0]  TCount;  
always @ (posedge clk or negedge rst_n)  
    if(!rst_n)  
        TCount <= 28'd0;  
    else if(TCount >= T_1s)  
        TCount <= 'd0;  
    else  
        TCount <= TCount + 1'b1;  
  
reg TCountCnt;  
always @ (posedge clk or negedge rst_n)  
    if(!rst_n)  
        TCountCnt <= 1'b0;  
    else if(TCount >= T_1s)  
        TCountCnt <= ~TCountCnt;  
          
/***********????************/  
reg startCnt;  
always @ (posedge Sig_in)  
    if(TCountCnt == 1'b1)  
        startCnt <= 1'b1;  
    else  
        startCnt <= 1'b0;  
  
/************????????************/  
reg [31:0]  SigTemp;  
always @ (negedge Sig_in)  
    if(startCnt == 1'b1)  
        SigTemp <= SigTemp + 1'b1;  
    else  
        SigTemp <= 'd0;  
/***************????***********/  
reg [13:0]  FreOut;  //32bit  9999--> 14bit
always @ (negedge startCnt)  
    FreOut <= SigTemp;  
      
      
assign  Fre = FreOut;     
endmodule  