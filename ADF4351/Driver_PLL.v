//pll_driver 
//adf4351
module adf4351(
	input clk, rst_n,
	input update,
	input [28:0] data_5, data_4, data_3, data_2, data_1, data_0,
	output reg CLK, DATA, LE, CE, PDBRF,
	input MUXOUT, LD

);
//get update up_edge
	reg [1:0] update_dly;initial update_dly = 'b0;
	always@(posedge clk)begin
		if(~rst_n) update_dly <= 'b0;
		else update_dly <= {update_dly[0], update};
	end
	wire en_up = (update_dly == 2'b01) || (update_dly == 2'b10);  //update convert -> up

//
	reg [2:0] cnt_reg; initial cnt_reg = 3'd6;
	reg [31:0] data_shift; initial data_shift = 'b0;

//initial port
	initial begin PDBRF = 1'b1; CE = 1'b1; CLK = 'b0; DATA = 'b0; LE = 'b0; end

//set FSM

	localparam IDLE = 4'b0001;
	localparam WAIT = 4'b0010;
	localparam PRE  = 4'b0100;
	localparam SEND = 4'b1000;
	reg [3:0] cstate, nstate;
	reg [2:0] p_cnt;
	reg [5:0] w_cnt, pre_cnt;
	reg [1:0] clk_div;        //3 div
	reg [6:0] s_cnt;
	initial begin p_cnt = 'b0; w_cnt = 'b0; pre_cnt = 'b0; clk_div = 'b0; s_cnt = 'b0; cstate = IDLE;  end
	
	always@(posedge clk)begin
		if(~rst_n) begin nstate <= IDLE; cstate <= IDLE;end
		else cstate <= nstate;
	end
	always@(posedge clk)begin
		if(~rst_n) p_cnt <= 'b0;
		else p_cnt <= p_cnt + 1'b1;
	end
	always@(posedge clk) begin
		if(~rst_n)	w_cnt <= 'b0;
		else if(cstate == WAIT)
			if(w_cnt < 6'd25)		    
			w_cnt <= w_cnt + 'b1;   
			else
			w_cnt <= 'b0;
		else w_cnt <= 'b0;
	end
	always@(posedge clk) begin
		if(~rst_n)	pre_cnt <= 'b0;
		else if(cstate == PRE)
			if(pre_cnt < 6'd15)		    
			pre_cnt <= pre_cnt + 'b1;   
			else
			pre_cnt <= 'b0;
		else pre_cnt <= 'b0;
	end
	always@(posedge clk) begin
		if(~rst_n)	clk_div <= 'b0;
		else if(cstate == SEND)
			if(clk_div < 2'd2)		    
			clk_div <= clk_div + 'b1;   
			else
			clk_div <= 'b0;
		else clk_div <= 'b0;
	end
	wire en_clk = (clk_div == 2'd2);
	always@(posedge clk) begin
		if(~rst_n)	s_cnt <= 'b0;
		else if(cstate == SEND)
			if(en_clk)		    
			s_cnt <= s_cnt + 'b1;   
			else
			s_cnt <= s_cnt;
		else s_cnt <= 'b0;
	end
		
//state change
	always@(cstate, p_cnt, w_cnt, pre_cnt, s_cnt, en_up) begin
		nstate = IDLE;
		case(cstate)
		IDLE: begin
			if(p_cnt == 3'd7)
				nstate <= WAIT;
			else 
				nstate <= IDLE;
			end
		WAIT: begin
			if(en_up)
				nstate <= PRE;
			else 
				nstate <= WAIT;
			end
		PRE:  begin
			if((pre_cnt == 6'd15)&&(cnt_reg == 3'd6)) nstate <= WAIT;
			else if((pre_cnt == 6'd15)&&(cnt_reg < 3'd6)) nstate <= SEND;
			else nstate <= PRE;
		      end
		SEND: begin
			if(s_cnt == 7'd70)
				nstate <= PRE;
			else
				nstate <= SEND;
			end
		default: begin
			nstate <= IDLE;
			end
		endcase
	end
	
//state detail
	always@(posedge clk) begin
		if(~rst_n) begin
			CLK <= 'b0; DATA <= 'b0; LE <= 'b0;
			data_shift <= 'b0;
		end else 
		case(cstate)
			IDLE: begin
				CLK <= 'b0; DATA <= 'b0; LE <= 'b0;
				data_shift <= 'b0;
			end
			WAIT: begin
				CLK <= 1'b0;
				DATA <= 1'b0;
				LE <= 1'b0;
				data_shift <= 'b0;
			end
			PRE : begin
				CLK <= 1'b0;
				DATA <= 1'b0;
				LE <= 1'b0;
				if(pre_cnt == 6'd5) cnt_reg <= (cnt_reg == 3'd0)? 3'd6:(cnt_reg - 3'd1);
				else if(pre_cnt == 6'd8) begin
					 data_shift <= {(cnt_reg == 3'd5)?data_5:
						        (cnt_reg == 3'd4)?data_4:
							(cnt_reg == 3'd3)?data_3:
							(cnt_reg == 3'd2)?data_2:
							(cnt_reg == 3'd1)?data_1:
							data_0,cnt_reg};
				end else data_shift <= data_shift;
//				if(pre_cnt == 6'd8) begin cnt_reg = (cnt_reg == 3'd0)? 3'd6:(cnt_reg - 3'd1); end
			end
			SEND: begin					
				if(en_clk&&(s_cnt < 7'd64)) CLK = ~CLK;				  
				if((s_cnt!=7'b0)&&(s_cnt[0])&&(en_clk)) begin
					data_shift <= data_shift << 1;
				end else
					data_shift <= data_shift;
				DATA <= data_shift[31];
				LE <= (s_cnt >=7'd65)? 1'b1:1'b0;
			end
			default: begin
				CLK <= 'b0; DATA <= 'b0; LE <= 'b0;
				data_shift <= 'b0;
			end
			endcase
	end
endmodule 