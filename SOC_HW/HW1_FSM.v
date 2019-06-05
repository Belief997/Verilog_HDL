
module HW1_FSM_4
(
	input clk, rst_n,
	input X,
	output  Z
);

//initial state &  to change number (one_hot) 
	reg[3 : 0] 	state, next_state;
	localparam S0 = 4'h1;
	localparam S1 = 4'h2;
	localparam S10 = 4'h4;
	localparam S100 = 4'h8;

always@(posedge clk or negedge rst_n) begin
	if(!rst_n) state <= S0;
	else 	state <= next_state;
end

//state change
always@(*) begin
	next_state = 4'bxxxx;
	case(state)
	S0:begin    //if + else if to change state by all input (real value) singal
		if(X) next_state = S1;
		else  next_state = S0;
	    end
	S1:begin
		if(X) next_state = S1;
		else  next_state = S10;
	    end
	S10:begin
		if(X) next_state = S1;
		else  next_state = S100;
	    end
	S100:begin	
		if(X) next_state = S1;
		else  next_state = S0;
	    end
	default: next_state = 4'b0;
	endcase
end

//output
assign Z = X && (state == S100);//process output
endmodule 

module HW1_FSM_8 
(
	input clk, rst_n,
	input X,
	output  Z
);

//initial state &  to change number (one_hot) 
	reg[7 : 0] 	state, next_state;
	localparam S000 = 8'h1;
	localparam S001 = 8'h2;
	localparam S010 = 8'h4;
	localparam S011 = 8'h8;
	localparam S100 = 8'h16;
	localparam S101 = 8'h32;
	localparam S110 = 8'h64;
	localparam S111 = 8'h128;

always@(posedge clk or negedge rst_n) begin
	if(!rst_n) state <= S000;
	else 	state <= next_state;
end

//state change
always@(*) begin
	next_state = 8'bxxxx;
	case(state)
	S000:begin    //if + else if to change state by all input (real value) singal
		if(X) next_state = S001;
		else  next_state = S000;
	    end
	S001:begin
		if(X) next_state = S011;
		else  next_state = S010;
	    end
	S010:begin
		if(X) next_state = S101;
		else  next_state = S100;
	    end
	S011:begin  
		if(X) next_state = S111;
		else  next_state = S110;
	    end
	S100:begin	
		if(X) next_state = S001;
		else  next_state = S000;
	    end
	S101:begin
		if(X) next_state = S011;
		else  next_state = S100;
	    end
	S110:begin	
		if(X) next_state = S101;
		else  next_state = S100;
	    end	
	S111:begin	
		if(X) next_state = S111;
		else  next_state = S110;
	    end
	default: next_state = 8'b0;
	endcase
end

//output
assign Z = X && (state == S100);//process output
endmodule 