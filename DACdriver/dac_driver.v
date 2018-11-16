
//dac driver for dac8811 test
//50M CLK 100M clk
//400ns 2.5MSPS
//input unsigned
module dac_driver(
	input clk, nrst,//low active
	input wire unsigned [15:0] data,
	output reg CS, CLK, SDI

);
	reg [3:0] p_count;
	reg [1:0] wait_count;
	reg [5:0] conv_count;
	reg unsigned [15:0] data_reg;
	reg [2:0] cstate, nstate;

	localparam IDLE = 3'b001;
	localparam WAIT = 3'b010;
	localparam CONV = 3'b100;
	
	initial begin p_count = 4'b0; wait_count = 2'b0; conv_count = 6'b0; cstate = IDLE; end

	always@(posedge clk or negedge nrst) begin
		if(!nrst)
			cstate <= IDLE;
		else
			cstate <= nstate;
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
			conv_count <= 6'b0;
		else if(cstate == CONV)//|| nstate == CONV) //when it becomes CONV,conv_cnt start from 0
			if(conv_count < 6'd36)		    //on conv_cnt == 34, data transmit and hold is done ,  get >=20ns to convert 
			conv_count <= conv_count + 6'b1;    //when cnt == 36, nstate== WAIT,after a clk_time cstate->WAIT, after a clk_time CS^(36+2*10=20ns)
			else
			conv_count <= 6'b0;
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
			if(conv_count == 6'd36)
				nstate = WAIT;
			else
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
			CLK <= 1'b1;
			SDI <= 1'b0;
			end
		else 
		case(cstate)
			IDLE: begin
				CS <= 1'b1;
				CLK <= 1'b1;
				SDI <= 1'b0;
				data_reg <= 16'b0;
				end
			WAIT: begin
				CS <= 1'b1;
				CLK <= 1'b1;
				SDI <= 1'b0;
				if(wait_count == 2'd2) begin
					data_reg <= data;
					end
				else 	data_reg <= data_reg;
				end
			CONV: begin					  //CLK^ is active , but CLK convert init is high  
				CS <= 1'b0;
				if((conv_count >= 0)&&(conv_count < 6'd32))//2:CLK^ get->1st  2*16=32:CLK^ get->16th  
				CLK = ~CLK;				  //so conv_cnt must reach 32 to do CLK^ get LSB,then CLK stay still(high),34 -> complied
				if(( !CLK)&&(conv_count[0]==1'b0)) begin//CLK \, update and send one bit
				data_reg <= {data_reg[14:0],1'b0};
				SDI <= data_reg[15];  end
				else
					data_reg <= data_reg;
				end
			default: begin
				CS <= 1'b1;
				CLK <= 1'b1;
				SDI <= 1'b0;
				data_reg <= data_reg;
				end
			endcase
	end
 


endmodule










