

module AD9854_t(
	input clk, rst_n,
	input [47:0] FreqWord,
	output reg MRST, WR,
	/* (* mark_debug="true" *)*/output reg RD,
	inout UDCLK,
	output reg [5:0] A,
//	output reg [7:0] D 
    inout   [7:0] D 
);
//init port
    reg en_UD, UD, en_D;
   /* (* mark_debug="true" *)*/reg [7:0] reg_DO;
  /*(* mark_debug="true" *)*/reg [7:0] reg_DI;///
  /* (* mark_debug="true" *)*/wire [7:0] DI; 
    assign UDCLK = en_UD? UD : 1'bz;
	initial begin MRST = 'b1; WR = 'b1; RD = 'b1; en_UD = 'b0; en_D = 'b1; UD = 'b0;  A = 'b0; reg_DO = 'b0; reg_DI = 'b0; /*D = 'b0; */ ///
	 end
	
//setting
	reg [47:0] data_shift;initial data_shift = 'b0;
	assign D = en_D? reg_DO : 8'hzz;///



//set FSM
	localparam IDLE = 4'b0001;
	localparam INIT = 4'b0010;
	localparam AMP = 4'b0110;
	localparam WAIT = 4'b0100;
	localparam SEND = 4'b1000;
	localparam READ = 4'b1100;
	reg [3:0] cstate, nstate;
	reg [3:0] p_cnt;
	reg [5:0] i_cnt;
	reg [5:0] a_cnt;
	reg [3:0] w_cnt;
	reg [4:0] s_cnt;
	reg [4:0] r_cnt;
	reg [2:0] clk_div;
	initial begin p_cnt = 'b0; i_cnt = 'b0; a_cnt = 'b0;w_cnt = 'b0; s_cnt = 'b0; r_cnt = 'b0;clk_div = 'b0; cstate = 'b0; end

	always@(posedge clk)begin
		if(~rst_n) begin cstate <= IDLE;end
		else cstate <= nstate;
	end
	always@(posedge clk)begin
		if(~rst_n) p_cnt <= 'b0;
		else p_cnt <= p_cnt + 1'b1;
	end
	always@(posedge clk) begin
		if(~rst_n)	i_cnt <= 'b0;
		else if(cstate == INIT)
			if(i_cnt < 6'd63)		    
			i_cnt <= i_cnt + 'b1;   
			else
			i_cnt <= 'b0;
		else i_cnt <= 'b0;
	end
	always@(posedge clk) begin
            if(~rst_n)    a_cnt <= 'b0;
            else if(cstate == AMP)
                if(a_cnt < 6'd63)            
                a_cnt <= a_cnt + 'b1;   
                else
                a_cnt <= 'b0;
            else a_cnt <= 'b0;
        end
	always@(posedge clk) begin
		if(~rst_n)	w_cnt <= 'b0;
		else if(cstate == WAIT)
			if(w_cnt < 4'd15)		    
			w_cnt <= w_cnt + 'b1;   
			else
			w_cnt <= 'b0;
		else w_cnt <= 'b0;
	end
	always@(posedge clk) begin
		if(~rst_n)	clk_div <= 'b0;
		else if(cstate == SEND)
			if(clk_div < 3'd4)		    
			clk_div <= clk_div + 'b1;   
			else
			clk_div <= 'b0;
		else clk_div <= 'b0;
	end
	wire en_clk = (clk_div == 2'd1) || (clk_div == 2'd3);
	always@(posedge clk) begin
		if(~rst_n)	s_cnt <= 'b0;
		else if(cstate == SEND)
			if(en_clk)		    
			s_cnt <= s_cnt + 'b1;   
			else
			s_cnt <= s_cnt;
		else s_cnt <= 'b0;
	end
///////////////////////////////////////////////////////
	always@(posedge clk) begin
    if(~rst_n)    r_cnt <= 'b0;
    else if(cstate == READ)
        if(r_cnt < 5'd31)            
        r_cnt <= r_cnt + 'b1;   
        else
        r_cnt <= 'b0;
    else r_cnt <= 'b0;
end




//state change
	always@(cstate, p_cnt, i_cnt, w_cnt, s_cnt, r_cnt) begin////
		nstate = IDLE;
		case(cstate)
		IDLE: begin
			if(p_cnt == 4'd15)
				nstate <= INIT;
			else 
				nstate <= IDLE;
			end
		INIT: begin
			if(i_cnt == 6'd63)
				nstate <= AMP;
			else 
				nstate <= INIT;
			end
        AMP: begin
                    if(a_cnt == 6'd63)
                        nstate <= WAIT;
                    else 
                        nstate <= AMP;
                    end
		WAIT: begin
			if(w_cnt == 4'd15)
				nstate <= SEND;
			else 
				nstate <= WAIT;
			end

//		WAIT: begin
//			if(w_cnt == 4'd15)
//				nstate <= READ;
//			else 
//				nstate <= WAIT;
//			end

//		SEND: begin
//			if(s_cnt == 4'd15)
//				nstate <= WAIT;
//			else
//				nstate <= SEND;
//			end



		SEND: begin
			if(s_cnt == 5'd18)
				nstate <= AMP;
			else
				nstate <= SEND;
			end
/////////////////////////////////////////////
		READ: begin
            if(r_cnt == 5'd31)
                nstate <= READ;
            else
                nstate <= READ;
            end
 ////////////////////////////////
		default: begin
			nstate <= IDLE;
			end
		endcase
	end
	
//state detail
	always@(posedge clk) begin
		if(~rst_n) begin
			MRST = 'b1; WR = 'b1; RD = 'b1; 
//			A = 'b0; D = 'b0; data_shift <= 'b0;
            A = 'b0; reg_DO = 'b0; data_shift <= 'b0;
			en_UD = 'b0; UD = 'b0; en_D <= 'b1;
		end else 
		case(cstate)
			IDLE: begin
				MRST = 'b1; WR = 'b1; RD = 'b1; 
//			A = 'b0; D = 'b0; data_shift <= 'b0;
                  A = 'b0; reg_DO = 'b0; data_shift <= 'b0;
				en_UD = 'b0; UD = 'b0; 
			end
			INIT: begin
			     en_UD = (i_cnt >= 6'd31); UD =( (i_cnt >= 6'd57) && (i_cnt >= 6'd60));
				MRST = ((i_cnt >= 5'd2) && (i_cnt <= 5'd12)); 
				WR = ~(((i_cnt >= 5'd23) && (i_cnt <= 5'd28)) || (i_cnt >= 6'd35)&&(i_cnt <= 6'd40)|| (i_cnt >= 6'd47)&&(i_cnt <= 6'd52)); 
				RD = 'b1; 
//				A = (i_cnt >= 5'd20)?6'h1F : 'b0; D = 'b0; data_shift <= 'b0;
                A =  (i_cnt >= 6'd44)?6'h20 :(i_cnt >= 6'd32)?6'h1E : (i_cnt >= 6'd20)?6'h1F : 'b0; 
                reg_DO = (i_cnt >= 6'd44)?8'h00 :(i_cnt >= 6'd32)?8'h48 : 8'h30;
                data_shift <= 'b0;
			end
			AMP: begin
                en_UD = 'b1;      en_D <= 'b1;
               MRST = 'b0;  RD = 'b1; 
            
               UD =( (i_cnt >= 6'd57) && (i_cnt >= 6'd60));
               
                WR = ~(((i_cnt >= 5'd23) && (i_cnt <= 5'd28)) || (i_cnt >= 6'd35)&&(i_cnt <= 6'd40));//|| (i_cnt >= 6'd47)&&(i_cnt <= 6'd52)); 
                
//                A = (i_cnt >= 5'd20)?6'h1F : 'b0; D = 'b0; data_shift <= 'b0;
                A =  (i_cnt >= 6'd20)?6'h21 :(i_cnt >= 6'd32)?6'h22 :/* (i_cnt >= 6'd20)?6'h1F :*/ 'b0; 
                reg_DO = (i_cnt >= 6'd20)?8'h0F :(i_cnt >= 6'd32)?8'hFF : 8'h00;//8'h20;
                data_shift <= 'b0;
            end
			WAIT: begin
			     en_UD = 'b1; UD ='d0;      en_D <= 'b1;
				MRST = 'b0;
				WR = 'b1; RD = 'b1; 
//				A = 6'h04; D = data_shift[47:40]; 
                A = 6'h04; reg_DO = data_shift[47:40]; 
				data_shift <= (w_cnt >= 4'd7)?FreqWord : 'b0;
			end
			SEND: begin					
				if(en_clk&&(s_cnt < 4'd12)) WR = ~WR;				  
				if((s_cnt!=7'b0)&&(s_cnt[0])&&(en_clk)) begin
					data_shift <= (data_shift << 8);
				end else begin
					data_shift <= data_shift; end
				A <= (clk_div == 3'd4)?(A + 1'b1) : A;
//				D <= data_shift[47:40];
				reg_DO <= data_shift[47:40]	;
				UD <= (s_cnt >= 4'd14);			
			end
			READ:begin
			     UD = 'b0;
//			     en_D <= ~((r_cnt >= 5'd5));
			     en_D <= 'b0;
			     RD <= ~((r_cnt >= 5'd5) && (r_cnt <= 5'd25));
			     A <= (r_cnt >= 5'd3) ? 7'h09 : A;
			     reg_DI <= (r_cnt == 5'd20) ? DI : reg_DI;
	
			end
			default: begin
				MRST = 'b1; WR = 'b1; RD = 'b1; 
//				A = 'b0; D = 'b0; data_shift <= 'b0;
				A = 'b0; reg_DO = 'b0; data_shift <= 'b0;
			end
			endcase
	end
endmodule 
