//100M clk 25M ram_clk
//specifically write & read
module wr_rd #(
	parameter DIW = 16,
	parameter DOW = 16,
	parameter ADW = 4

)(
	input clk,// ram_clk
	input [1:0] wr_rd,//wr 2'b10 , rd 2'b01
	input [DIW-1 : 0] din,
	input [ADW-1 : 0] addr,
	output reg [DOW-1 : 0] dout

);
	reg [DIW-1 : 0] din_reg, din_shift;
	reg [ADW-1 : 0] addr_reg, addr_shift;
	reg en, we;
	wire [DOW-1 : 0] dout_0=16'd666;

initial begin
	din_reg = 'b0;
	addr_reg = 'b0;
	dout = 'b0;
	en = 'b0;
	we = 'b0;
end

always@(posedge clk)begin
	din_reg <= din;
	addr_reg <= addr;
end

//count ram_clk 25M
reg [1:0] cnt4;//25M
initial cnt4 = 'b0;
always@(posedge clk) begin
	cnt4 <= cnt4 + 1'b1;
end
wire ram_clk = (cnt4[1]);

//delay chain
reg delay_0;
initial delay_0 = 'b0;
always@(posedge ram_clk)begin
	delay_0 <= wr_rd[0];
end
reg delay_1;
initial delay_1 = 'b0;
always@(posedge ram_clk)begin
	delay_1 <= delay_0;
end
reg delay_2;
initial delay_2 = 'b0;
always@(posedge ram_clk)begin
	delay_2 <= delay_1;
end

//write & read
always@(posedge clk)begin
	case(wr_rd)
	2'b10:begin//wr
		if(cnt4 == 2'b11) begin//negedge clk_ram
			din_shift <= 'b0;
			addr_shift <= 'b0;
			en <= 'b0;
			we <= 'b0;
		
		end
		else if(cnt4 == 2'b0) begin
			din_shift <= din_reg;
			addr_shift <= addr_reg;
			en <= 1'b1;
			we <= 1'b1;

		end
	end
	2'b01:begin//rd
		din_shift <= 'b0;
		we <= 'b0;
		if(cnt4 == 2'b0)begin
			addr_shift <= addr_reg;
			en <= 1'b1;
		end
		
		if(delay_2)begin
			dout <= dout_0;
//			en <= 'b0;
		end
		if(cnt4 == 2'd2)begin
		if(!delay_2)	en <= 'b0;
		end
	end
	2'b0:begin
		din_shift <= 'b0;
		addr_shift <= 'b0;
		en <= 'b0;
		we <= 'b0;
	end
	endcase

end



endmodule 