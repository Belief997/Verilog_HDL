module shift (
	input clk,rst_n,
	output   out

);
 parameter T_0s5 = 28'd19; //200M 0.0005s

/***********set gate**********/// 
reg [27:0]  PreCnt;  initial PreCnt = 'b0;
always @ (posedge clk or negedge rst_n)  
    if(!rst_n)  
        PreCnt <= 'd0;  
    else if(PreCnt >= T_0s5 + 3'd3 )  
        PreCnt <= 'd0;  
    else  
        PreCnt <= PreCnt + 1'b1;  
  
reg PreGate;  initial PreGate = 'b1;
always @ (posedge clk or negedge rst_n)  
    if(!rst_n)  
        PreGate <= 1'b0;  
    else if((PreCnt == T_0s5) || (PreCnt == 28'd22)) 
        PreGate <= ~PreGate;  
 
assign out = PreGate;         

endmodule 
