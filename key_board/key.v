
module key(
	input clk,
	output reg [3:0] row,//hang
	input [3:0] key_col
);
	initial row = 'b0;

	reg [31:0] cnt10ms; initial cnt10ms = 'b0;
	always@(posedge clk)begin
		if(cnt10ms < 32'd1_000_000)
		cnt10ms <= cnt10ms + 1'b1;
		else cnt10ms <= 'b0;
	end
	wire co = (cnt10ms == 32'd1_000_000)

	reg [1:0] cnt; initial cnt = 'b0;
	always@(posedge clk)begin
		if(co)	cnt <= cnt + 'b1;
	end

	always@(posedge clk)begin
		if(cnt == 2'd0) row <= 4'h1;
		else if(cnt == 2'd1) row <= 4'h2;
		else if(cnt == 2'd2) row <= 4'h4;
		else  row <= 4'h8;
	end

	wire [3:0] col;
	reg [7:0] key; initial key ='b0;
	always@(posedge clk)begin
		key <= {row,col};

	end





endmodule 