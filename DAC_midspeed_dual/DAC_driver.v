//TLS7528
//daul 120ns 60ns
//8.3M unsigned 8 bit
module dac_driver(
	input clk, nrst,//low active
	input wire  [7:0] data_1, data_2,
	output reg CS, WR, CAB,
	output reg [7:0] DATA
);

	reg [3:0] p_count;
	reg [1:0] wait_count;
	reg [4:0] conv_count;
	reg [7:0] data_reg_1, data_reg_2;
	reg [2:0] cstate, nstate;

	localparam IDLE = 3'b001;
	localparam WAIT = 3'b010;
	localparam CONV = 3'b100;
	
	initial begin p_count = 4'b0; wait_count = 2'b0; conv_count = 5'b0; cstate = IDLE; end

	always@(posedge clk or negedge nrst) begin
		if(!nrst)
			cstate <= IDLE;
		else
			cstate <= nstate;
	end

	always@(posedge clk or negedge nrst) begin
		if(!nrst)
			data_reg_1 <= 'b0;
		else
			data_reg_1 <= data_1;
	end
	always@(posedge clk or negedge nrst) begin
		if(!nrst)
			data_reg_2 <= 'b0;
		else
			data_reg_2 <= data_2;
	end

	always@(posedge clk or negedge nrst) begin
		if(!nrst)
			p_count <= 4'b0;
		else
			p_count <= p_count + 4'b1;
	end
			
	always@(posedge clk or negedge nrst) begin
		if(!nrst)
			wait_count <= 2'b0;
		else if(cstate == WAIT || nstate == WAIT)
			wait_count <= wait_count + 2'b1;
	end

	always@(posedge clk or negedge nrst) begin
		if(!nrst)
			conv_count <= 5'b0;
		else if(cstate == CONV)
			if(conv_count < 5'd23)		 
			conv_count <= conv_count + 6'b1;    
			else
			conv_count <= 'b0;
	end
	always@(cstate, p_count, wait_count, conv_count) begin
		nstate = IDLE;
		case(cstate)
		IDLE: begin
			if(p_count == 4'd15)
				nstate = WAIT;
			else 
				nstate = IDLE;
			end
		WAIT: begin
			if(wait_count == 2'd3)
				nstate = CONV;
			else 
				nstate = WAIT;
			end
		CONV: begin
//			if(conv_count == 6'd36)
//				nstate = CONV;
//			else
				nstate = CONV;
			end
		default: begin
			nstate = IDLE;
			end
		endcase
	end


	always@(posedge clk or negedge nrst) begin
		if(!nrst) begin
			CS <= 1'b1;
			WR <= 1'b1;
			CAB <= 1'b1;
			DATA <= 'b0;
			end
		else 
		case(cstate)
			IDLE: begin
				CS <= 1'b1;
				WR <= 1'b1;
				CAB <= 1'b1;
				DATA <= 8'b0;
				
			end
			WAIT: begin
				CS <= 1'b1;
				WR <= 1'b1;
				CAB <= 1'b1;
				DATA <= 'b0;
//				if(wait_count == 2'd2) begin
//					data_reg <= data;
//					end
//				else 	data_reg <= data_reg;
			end
			CONV: begin					   
				CS <= 1'b0;
				if((conv_count >= 0)&&(conv_count < 5'd12)) 
				CAB <= 1'b0;
				else CAB <= 1'b1;			
				if(((conv_count >= 0)&&(conv_count < 5'd10))||((conv_count >= 5'd12)&&(conv_count < 5'd22)))
				WR <= 1'b0; 
				else WR <= 1'b1;
//				if((conv_count == 5'd1)||(conv_count == 5'd13))	DATA <= data_reg; else DATA <= DATA;
				DATA <= (conv_count == 5'd1)? data_reg_1:(conv_count == 5'd13)?data_reg_2:DATA;
			end
			default: begin
				CS <= 1'b1;
				WR <= 1'b1;
				CAB <= 1'b1;
				DATA <= 8'b0;
				
			end
			endcase
	end
 

endmodule 
