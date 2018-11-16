
module divider#(parameter W1 = 32, W2 = 32)(
	input clk,
	input [W1 - 1 : 0] a,//divided,
	input [W2 - 1 : 0] b,//divider,
	output reg [W1 - 1 : 0] c//quotient

);
 
 
reg[W1 - 1:0] tempa;  
reg[W2 - 1:0] tempb;  
reg[2 * W1 - 1:0] temp_a;  
reg[2 * W2 - 1:0] temp_b; 
 
always @(a or b)  begin  
    	tempa <= a;  
    	tempb <= b;  
end  

integer i;  
always @(tempa or tempb)  begin  
    temp_a = tempa;  
    temp_b = (32'b1 * tempb) << W2;   
    for(i = 0;i < W1;i = i + 1)  begin  
            temp_a = {temp_a[2*W1 -1 :0],1'b0};  
            if(temp_a[2*W1 -1 :W1] >= tempb)  
                temp_a = temp_a - temp_b + 1'b1;  
            else  
                temp_a = temp_a;  
        end  
  
    c <= temp_a[W1 -1 :0];  
//    yyushu <= temp_a[63:32];  
end 





endmodule 