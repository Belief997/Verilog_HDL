`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:57:08 09/25/2018 
// Design Name: 
// Module Name:    manch_decoder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module manch_decoder(
    	clk,
	datamin,
	databout
);
	input clk;
	input datamin;
	output databout;
	reg databout;
	reg[1:0]com;
	reg flag;
	reg syn;

	always@(posedge clk)
  	begin
    		com<={com[0],datamin};
	end

	always@(posedge clk)begin
	  	if((com==2'b11)||(com==2'b00))
		begin
		   	flag<=2'b11;
			syn<=1'b1;
		end 
		else begin 
			syn<=1'b0;
		end
	end

	always@(posedge clk)begin 				
    		if((syn==1'b1)||(flag==2'b11))begin    			
         	case(com)
            		2'b01:
            			databout<=1'b0;
            		2'b10:
             			databout<=1'b1;
			default:
              			databout<=databout;
          	endcase
         	end
     	end  

endmodule
