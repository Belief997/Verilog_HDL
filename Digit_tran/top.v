
module top (
	input clk,
	input key1, key2,
	output reg [3:0] rate,
	output reg sig, noise, 
	output man, en0,
	output reg clock
);

//sig & noise out 
wire [7:0]sig_0;
wire [11:0] noise_0;
always@(posedge clk)begin
	sig <= sig_0[0];
	noise <= noise_0[0];
end

//rate select
wire k1, k2;
//reg [3:0] rate; 
initial rate = 'b1;
always@(posedge clk)begin
	if(k1)begin
		if(rate < 4'd10) rate <= rate + 1'b1;
		else rate <= 4'b1;
	end
	if(k2)begin
		if(rate > 4'b1) rate <= rate - 1'b1;
		else rate <= 4'd10;
	end
end

//div select
reg [13:0] div; initial div = 'b0;
always@(posedge clk)begin
	case(rate)
		4'd1:begin
			div <= 14'd10_000;
		end
		4'd2:begin
			div <= 14'd5_000;
		end
		4'd3:begin
			div <= 14'd3_333;
		end
		4'd4:begin
			div <= 14'd2_500;
		end
		4'd5:begin
			div <= 14'd2_000;
		end
		4'd6:begin
			div <= 14'd1_667;
		end
		4'd7:begin
			div <= 14'd1_429;
		end
		4'd8:begin
			div <= 14'd1_250;
		end
		4'd9:begin
			div <= 14'd1_111;
		end
		4'd10:begin
			div <= 14'd1_000;
		end
	endcase
end

//en1 en2 sig
reg [13:0] cnt_div; initial cnt_div = 'b0;
//wire en0 = (cnt_div == div - 1'b1); 
assign en0 = (cnt_div == div - 1'b1); 
wire en1 = (cnt_div == ((div >> 1) - 1'b1));
always@(posedge clk)begin
	if(cnt_div < (div - 1'b1))	cnt_div <= cnt_div + 1'b1;
	else cnt_div <= 'b0;
end

//en  clock
always@(posedge clk)begin
	if(en0) clock <= 1'b1;
	else if(en1) clock <= 1'b0;
	else clock <= clock;
end

//en10M noise
reg [3:0] cnt10; initial cnt10 = 'b0;
wire en10M = (cnt10 == 4'd9);
always@(posedge clk) begin
	if(cnt10 < 4'd9)	cnt10 <= cnt10 + 1'b1;
	else cnt10 <= 'b0;
end

wire enman, sysman;


//man filter 
wire [7:0] man_ad = (man)? 127 : 0;
wire [7:0] man_n  = man_ad + noise_0[2:0];



//////////////////////////////////////////////////////////
LFSR#( .W(8), .MASK (32'h11d) 
)the_sig(
	.clk(clk), .clken(en0),
	.lfsr(sig_0)
);

LFSR#( .W(12), .MASK (32'h1053) 
)the_noise(
	.clk(clk), .clken(en10M),
	.lfsr(noise_0)
);

man_coder the_man(
	.clk(clk),
	.en0(en0), .en1(en1),
	.in(sig_0[0]),
	.out(man)
);

keys the_keys (
	.clk(clk),
	.key0(key1),.key1(key2),//.key2(),
	.k0(k1),.k1(k2)//,.k2()

);
////////////////////////////////////////////////////////////////
 get_sysen the_mansys(
	.clk(clk),
	.man(man),
	.en(enman), 
	.sys(sysman)

);

////////////////////////////////////////////////////////////////
//wire out_w;
//LFSR_w #(  
//    .W(8),
//    .POLY(9'h11D)
//) the_w( 
//  .clk(clk),
//    .arst(1'b0),
//    .en(en0),
//    .out(out_w)
//);
endmodule   