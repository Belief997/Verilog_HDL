module FSM #(parameter STATE_NUM = 4)
(
	input clk,rst ,
	input k0,k1,
	output  out0,out1	
);

//initial state &  to change number (one_hot) 
	reg[3 : 0] 	state, next_state;
	localparam s_0 = 4'h1;
	localparam s_1 = 4'h2;
	localparam s_2 = 4'h4;
	localparam s_3 = 4'h8;

always@(posedge clk) begin
	if(rst) state <= s_0;
	else 	state <= next_state;
end

//state change
always@(*) begin
	next_state = 4'bxxxx;
	case(state)
	s_0:begin    //if + else if to change state by all input (real value) singal
		if(k0) next_state = s_1;
		else if(k1) next_state = s_2;
	    end
	s_1:begin
		if(k0) next_state = s_2;
		else if(k1) next_state = s_0;
	    end
	s_2:begin
		if(k0) next_state = s_3;
		else if(k1) next_state = s_1;
	    end
	s_3:begin	
		if(k0) next_state = s_2;
		else if(k1) next_state = s_0;
	    end
	default: next_state = 4'bxxxx;
	endcase
end

//output
assign out_0 = (state == s_2) || (state == s_3);//state output
assign out_1 = k0 && (state == s_2);//process output
endmodule 