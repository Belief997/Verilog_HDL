//seting pre-gate
module gate(
	input clk200M, rst_n,
	output reg PreGate
);
//gate convert time
	localparam	T_0s5 = 31'd200_000_000;//T_1s 200M  gate convert time
//	localparam	T_0s5 = 28'd99_999_999;//0.5s

	reg [31:0]  PreCnt;  initial PreCnt = 'b0;
	always @ (posedge clk200M or negedge rst_n)  begin
   	 if(!rst_n)  
  	      PreCnt <= 'd0;  
  	  else if(PreCnt >= (T_0s5 - 1'b1))  
  	      PreCnt <= 'd0;  
  	  else  
  	      PreCnt <= PreCnt + 1'b1;  
  	end

	 initial PreGate = 'b0;
	always @ (posedge clk200M or negedge rst_n)begin  
   	 if(!rst_n)  
  	      PreGate <= 1'b0;  
   	 else if(PreCnt >= (T_0s5 - 1'b1))  
     	   PreGate <= ~PreGate;  
          end

endmodule 