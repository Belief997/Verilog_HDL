//100M 50M common clk
//1M wr_en
module FIFO_cycle(
	input clk,
	input [7:0] datain,
	input en0, en1,
//	output [7:0] dataout,
	output reg [7:0] max, min

);
	reg [7:0] data_reg;
	reg clk_wrd, wr_en, rd_en;
	reg [31:0] cnt_wr;
	reg [7:0] data_temp;
	reg [7:0] max_temp, min_temp;
	wire [7:0] dataout;
	
initial begin
	data_reg = 'b0;
	clk_wrd = 'b1;//////////
	wr_en = 'b0;
	cnt_wr = 'b0;
	max_temp = 'b0;
	min_temp = 8'd255;
	max = 'b0;
	min = 8'd255;
end


	localparam IDLE = 3'b001;
	localparam WR = 3'b010;
	localparam RD = 3'b100;

	reg [2:0] cstate, nstate;  initial cstate = 'b0;
	always@(posedge clk) cstate <= nstate;

reg [2:0] p_cnt; initial p_cnt = 'b0;
always@(posedge clk) begin
	p_cnt <= p_cnt + 3'b1;
end

reg [6:0] cnt_1M; initial cnt_1M = 'b0;
always@(posedge clk)begin
	if(cstate == WR)begin
		if(cnt_1M < 7'd99) cnt_1M <= cnt_1M + 1'b1;
		else cnt_1M <= 'b0;
	end
	else cnt_1M <= 'b0;
end 

reg [31:0] w_cnt;initial w_cnt = 'b0;
always@(posedge clk)begin
	if(cstate == WR)begin
		w_cnt <= w_cnt + 1'b1;
	end
	else w_cnt <= 'b0;
end

reg [31:0] r_cnt;initial r_cnt = 'b0;
always@(posedge clk)begin
	if(cstate == RD)begin
		r_cnt <= r_cnt + 1'b1;
	end
	else r_cnt <= 'b0;
end

	always@(en0,en1)begin
		nstate <= IDLE;
		case(cstate)
		IDLE:begin
			if(en0)	nstate <= WR;
			else 	nstate <= IDLE;
		end
		WR:begin
			if(en1) nstate <= RD;
			else	nstate <= WR;
		end
		RD:begin
			if(en0)	nstate <= WR;
			else 	nstate <= RD;
		end
		default:begin
			nstate <= IDLE;
		end
		endcase
	end

	always@(posedge clk)begin
		case(cstate)
		IDLE:begin
			clk_wrd <= 1'b1;
			data_reg <= 'b0;
			wr_en <= 'b0;
			rd_en <= 'b0;
		end
		WR:begin
			if(w_cnt < 31'd2)begin
			clk_wrd <= 'b0; rd_en <= 'b0; cnt_wr <= 'b0; max_temp <= 'b0; min_temp <= 8'd255;
			end else clk_wrd <= ~clk_wrd;
			if((cnt_1M > 7'd18) && (cnt_1M < 7'd21)) wr_en <= 1'b1;
			else wr_en <= 'b0;
			if(clk_wrd && (cnt_1M == 7'd19)) data_reg <= datain;
			else data_reg <= data_reg;
			if(cnt_1M == 7'd21) cnt_wr <= cnt_wr + 1'b1;
			
		end
		RD:begin
			if(r_cnt < 31'd2) begin
				wr_en <= 'b0;
				clk_wrd <= 'b0;
				rd_en <= 1'b1;
			end
			else begin
				clk_wrd <= ~clk_wrd;
				
			end
			if((r_cnt > (31'd2 + (cnt_wr >> 1) )) && (r_cnt < (31'd2 + ((cnt_wr - (cnt_wr >> 2))<<1) )) && (clk_wrd))begin
				if(r_cnt == (31'd3 + (cnt_wr >> 1)))begin
					max_temp <= datain;//datain  dataout
					min_temp <= datain;
				end
				else begin
					max_temp <= (datain > max)? datain : max;
					min_temp <= (datain < min)? datain : min; 
						
				end
				
			end
			else if(r_cnt >= (31'd2 + ((cnt_wr - (cnt_wr >> 2))<<1) )) begin
				data_temp <= datain;
				max <= max_temp;
				min <= min_temp;
			end
		end


		endcase

	end

endmodule 