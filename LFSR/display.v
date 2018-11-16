
module display(
	input clk,
	input [13:0]data,
	output reg [11:0]Seg
);
reg [13:0] Bin;
wire [15:0] Bcd;
wire [3:0] Bcd1 = Bcd[3:0];
wire [3:0] Bcd2 = Bcd[7:4];
wire [3:0] Bcd4 = Bcd[11:8];
wire [3:0] Bcd8 = Bcd[15:12];
wire [6:0] Seg1, Seg2, Seg4, Seg8;

reg [19:0] cntscan;
reg [1:0] ds;
initial begin
	Bin ='b0;
	cntscan = 'b0;
	ds = 'b0;
	Seg = 'b0;
end
always@(posedge clk)begin
	Bin <= data;
	
end
always@(posedge clk) begin
	if(cntscan < 20'd100) cntscan <= cntscan + 1'b1;
	else cntscan <= 'b0;

end
always@(posedge clk)begin//to change scan cnt time 10ms -> 1_000_000 
	if(cntscan == 20'd100)	ds <= ds + 1'b1;
end
	
always@(posedge clk)begin//from low to high
	case (ds)
		2'b00:begin
			Seg <= {4'b0001,Seg1,1'b0};
		end
		2'b01:begin
			Seg <= {4'b0010,Seg2,1'b0};
		end
		2'b10:begin
			Seg <= {4'b0100,Seg4,1'b0};
		end
		2'b11:begin
			Seg <= {4'b1000,Seg8,1'b0};
		end
		default:begin
			Seg <= Seg;
		end
	endcase
end





Bin2Bcd the_Bcd(
	.clk(clk),
	.Bin(Bin),//0~9_999
	.Bcd(Bcd)
);

Bcd2Seg Seg0001(
	.clk(clk),
	.Bcd(Bcd1),
	.Seg(Seg1)
);
Bcd2Seg Seg0010(
	.clk(clk),
	.Bcd(Bcd2),
	.Seg(Seg2)
);
Bcd2Seg Seg0100(
	.clk(clk),
	.Bcd(Bcd4),
	.Seg(Seg4)
);
Bcd2Seg Seg1000(
	.clk(clk),
	.Bcd(Bcd8),
	.Seg(Seg8)
);
endmodule 