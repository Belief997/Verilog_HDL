//200M clk
//0.5s gate
//10Hz ~ 1MHz 
module  FreMeasure(  
    input clk, rst_n,  //low active
    input Sig_in,  
    output [31:0] Fre  //change the width 
);  
//parameter T_1s = 28'd49_999_999; //50M
//parameter T_0s5 = 28'd99_999_999; //200M 0.5s
 parameter T_0s5 = 28'd99_999; //200M 0.0005s

/***********set gate**********/// 
reg [27:0]  PreCnt;  initial PreCnt = 'b0;
always @ (posedge clk or negedge rst_n)  
    if(!rst_n)  
        PreCnt <= 'd0;  
    else if(PreCnt >= T_0s5)  
        PreCnt <= 'd0;  
    else  
        PreCnt <= PreCnt + 1'b1;  
  
reg PreGate;  initial PreGate = 'b0;
always @ (posedge clk or negedge rst_n)  
    if(!rst_n)  
        PreGate <= 1'b0;  
    else if(PreCnt >= T_0s5)  
        PreGate <= ~PreGate;  
          
/***********real gate************/  
reg RealGate;  initial RealGate = 'b0;
always @ (posedge Sig_in)  
    if(PreGate == 1'b1)  
        RealGate <= 1'b1;  
    else  
        RealGate <= 1'b0;  
  
/************count freq in the real gate************/  
reg [31:0]  FreTemp;  initial FreTemp = 'b0; 
always @ (negedge Sig_in)  
    if(RealGate == 1'b1)  
        FreTemp <= FreTemp + 1'b1;  
    else  
        FreTemp <= 'd0;  
/***************lock & output***********/  
reg [31:0]  FreOut;  initial FreOut = 'b0; //32bit  9999--> 14bit  change measure freq data width
always @ (negedge RealGate)  
    FreOut <= FreTemp;  
        
assign Fre = FreOut * 200 ;     
endmodule  
