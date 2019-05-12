
module bpc_gen(
	input clk, rst_n,
	output bpc, bpc_n

);

localparam T_CNT_1S  = 32'd100; // 10ms -> 1s 

reg [31:0] cnt_20s;
reg [31:0] cnt_1s;
reg [31:0] cnt_20;
initial begin
	cnt_20s = 'b0;
	cnt_1s  = 'b0;
	cnt_20  = 'b0;
end

always@(posedge clk or negedge rst_n) begin
	if(!rst_n)begin
		//cnt_20s <= 'b0;
		cnt_1s  <= 'b0;
	end else begin
		if(cnt_1s < (T_CNT_1S - 1)) begin
			cnt_1s <= cnt_1s + 1;
		end else begin
			cnt_1s <= 'b0;
		end
	end
end
wire en_1s = (cnt_1s == (T_CNT_1S - 1));

always@(posedge clk or negedge rst_n) begin
	if(!rst_n)begin
		cnt_20 <= 'b0;
	end else if(en_1s)begin
		if(cnt_20 < 19)begin
			cnt_20 <= cnt_20 + 1;
		end else begin
			cnt_20 <= 'b0;
		end
	end
end

/*******  time ********/
reg [7:0] hr, min, sec, wk;
reg flg_noon ;  // 0: forenoon 1: afternoon
reg [7:0] day, mon, yr;
initial begin
	hr = 'd9;
	min = 'd10;
	sec = 'b0;
	flg_noon = 'b0;
	wk = 'd7;
	day = 'd12;
	mon = 'd5;
	yr = 'd19;
end
 
/* output */
localparam GATE_0 = 32'd10; // 10ms -> 100ms
localparam GATE_1 = 32'd20; // 10ms -> 200ms
localparam GATE_2 = 32'd30; // 10ms -> 300ms
localparam GATE_3 = 32'd40; // 10ms -> 400ms

reg reg_bpc = 'b0;
reg [31:0] cnt_gate = 'b0;
always@(posedge clk or negedge rst_n)begin
	if(!rst_n) begin
		reg_bpc <= 'b0;
	end else begin
	    case(cnt_20)
	        32'd0:
		 begin
		  reg_bpc <= 'b0;
		 end
		32'd1:
		 begin // P1
		  cnt_gate <= (sec == 8'd20)? GATE_1 : (sec == 8'd40)? GATE_2 : GATE_0;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end
		32'd2:
		 begin // P2
    		   reg_bpc <= 'b0;
		 end
		32'd3:
		 begin // HR1
		  cnt_gate <= (hr[3:2] == 2'b00)? GATE_0 : (hr[3:2] == 2'b01)? GATE_1 : (hr[3:2] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end
		32'd4:
		 begin // HR2
		  cnt_gate <= (hr[1:0] == 2'b00)? GATE_0 : (hr[1:0] == 2'b01)? GATE_1 : (hr[1:0] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end
		32'd5:
		 begin // MN1
		  cnt_gate <= (min[5:4] == 2'b00)? GATE_0 : (min[5:4] == 2'b01)? GATE_1 : (min[5:4] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end
		32'd6:
		 begin // MN2
		  cnt_gate <= (min[3:2] == 2'b00)? GATE_0 : (min[3:2] == 2'b01)? GATE_1 : (min[3:2] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end
		32'd7:
		 begin // MN3
		  cnt_gate <= (min[1:0] == 2'b00)? GATE_0 : (min[1:0] == 2'b01)? GATE_1 : (min[1:0] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end
		32'd8:
		 begin // W1
		  cnt_gate <= (wk[3:2] == 2'b00)? GATE_0 : (wk[3:2] == 2'b01)? GATE_1 : (wk[3:2] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end
		32'd9:
		 begin // W2
		  cnt_gate <= (wk[1:0] == 2'b00)? GATE_0 : (wk[1:0] == 2'b01)? GATE_1 : (wk[1:0] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end
		32'd10:
		 begin // P3
		  // even forenoon, odd forenoon, odd afternoon
		  cnt_gate <= ( !(^{hr[3:0],min[5:0],wk[3:0]}) && (!flg_noon))? GATE_0 : /*// \*/
			      (  (^{hr[3:0],min[5:0],wk[3:0]}) && (!flg_noon))? GATE_1 : /*// \*/
			      (  (^{hr[3:0],min[5:0],wk[3:0]}) && ( flg_noon))? GATE_2 : GATE_3;
				
	          reg_bpc <= (cnt_1s < cnt_gate);
		 end		
		32'd11:
		 begin // day1
		  cnt_gate <= (day[5:4] == 2'b00)? GATE_0 : (day[5:4] == 2'b01)? GATE_1 : (day[5:4] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end
		32'd12:
		 begin // day2
		  cnt_gate <= (day[3:2] == 2'b00)? GATE_0 : (day[3:2] == 2'b01)? GATE_1 : (day[3:2] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end
		32'd13:
		 begin // day3
		  cnt_gate <= (day[1:0] == 2'b00)? GATE_0 : (day[1:0] == 2'b01)? GATE_1 : (day[1:0] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end
		32'd14:
		 begin // mon1
		  cnt_gate <= (mon[3:2] == 2'b00)? GATE_0 : (mon[3:2] == 2'b01)? GATE_1 : (mon[3:2] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end
		32'd15:
		 begin // mon2
		  cnt_gate <= (mon[1:0] == 2'b00)? GATE_0 : (mon[1:0] == 2'b01)? GATE_1 : (mon[1:0] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end
		32'd16:
		 begin // yr1
		  cnt_gate <= (yr[5:4] == 2'b00)? GATE_0 : (yr[5:4] == 2'b01)? GATE_1 : (yr[5:4] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end		
		32'd17:
		 begin // yr2
		  cnt_gate <= (yr[3:2] == 2'b00)? GATE_0 : (yr[3:2] == 2'b01)? GATE_1 : (yr[3:2] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end	
		32'd18:
		 begin // yr3
		  cnt_gate <= (yr[1:0] == 2'b00)? GATE_0 : (yr[1:0] == 2'b01)? GATE_1 : (yr[1:0] == 2'b10)? GATE_2: GATE_3;
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end	
		32'd19:
		 begin // P4
		  // even 0, odd 0, odd 1
		  cnt_gate <= ( !(^{day[2:0],mon[2:0],yr[2:0]}) && (!yr[6]))? GATE_0 : //\
			      (  (^{day[2:0],mon[2:0],yr[2:0]}) && (!yr[6]))? GATE_1 : //\
			      (  (^{day[2:0],mon[2:0],yr[2:0]}) && ( yr[6]))? GATE_2 : GATE_3;
				
	          reg_bpc <= (cnt_1s <= cnt_gate);
		 end	
		default:
		 begin
		  reg_bpc <= 'b0;
		 end
	    endcase

	end

end

assign bpc = reg_bpc;
assign bpc_n = ~reg_bpc;

endmodule 