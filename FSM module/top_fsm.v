`timescale 1ns/1ps
module top_fsm 
(
	input clk,rst,
	input [20:0] data,
	output  out

);
	reg sin ;
	 reg [20:0] d ;
initial d = 21'b1101_0101_0100_1010 ;
always begin
#34 
	sin <= d[0];
	d <= d >> 1;
end


//initial state &  to change number (one_hot) 
	reg[3 : 0] 	state, next_state;
	localparam s_0 = 4'h1;
	localparam s_1 = 4'h2;
	localparam s_2 = 4'h4;
	localparam s_3 = 4'h8;

initial begin
//state = s_0; 
next_state = s_0; 
end

always@(posedge clk) begin
	if(rst) state <= s_0;
	else 	state <= next_state;
end

//state change
always@(sin or posedge clk) begin
	//next_state = 4'bxxxx;
	case(state)
//	s_0:begin    //if + else if to change state by all input (real value) singal
//		if(sin == 1) next_state = s_0;
//		else if(sin == 0) next_state = s_1;
//	    end
//	s_1:begin
//		if(sin == 0) next_state = s_1;
//		else if(sin == 1) next_state = s_2;
//	    end
//	s_2:begin
//		if(sin == 1) next_state = s_0;
//		else if(sin == 0) next_state = s_3;
//	    end
//	s_3:begin	
//		if(sin == 0) next_state = s_1;
//		else if(sin == 1) next_state = s_2;
//	    end

	s_0:begin    //if + else if to change state by all input (real value) singal
		next_state = ((sin == 1)? s_0 : s_1);
		
	    end
	s_1:begin
		next_state = ((sin == 1)? s_2 : s_1);
	    end
	s_2:begin

		next_state = ((sin == 1)? s_0 : s_3);
	    end
	s_3:begin	

		next_state = ((sin == 1)? s_2 : s_1);
	    end
	default: next_state = s_0;//4'bxxxx;
	endcase
end

//output

//assign out = (sin == 1) && (state == s_3);
assign out = (sin && (state == s_3));

endmodule 
