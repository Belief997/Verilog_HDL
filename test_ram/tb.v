
module tb;
	reg clk;

initial clk = 'b0;
always #5 clk <= ~clk;

reg [1:0] wr_rd;
reg [15:0] din;
reg [3:0] addr;
wire [15:0] dout;

initial begin
	wr_rd = 'b0;
	din = 'b0;
	addr = 'b0;

	#100 wr_rd = 2'b10;
	din = 16'd10;
	addr = 16'd2;
	
	#200 wr_rd = 2'b10;
	din = 16'd20;
	addr = 16'd3;

	#290 wr_rd = 2'b01;
	din = 16'd10;
	addr = 16'd2;

	#500 wr_rd = 2'b10;
	din = 16'd10;
	addr = 16'd3;

end

wr_rd #(
	.DIW(16),
	.DOW(16),
	.ADW(4)

) the_ram(
	.clk(clk),// ram_clk
	.wr_rd(wr_rd),//wr 2'b10 , rd 2'b01
	.din(din),
	.addr(addr),
	.dout(dout)

);

endmodule 