module top_clk(
	input clk,rst,
	input keyHr, keyMin, keySec,
	output [6:0] hrSegL, hrSegH, minSegL, minSegH, secSegL, secSegH
);
	wire kHr,kMin,kSec;
	wire [6:0] Sec, Min, Hr;
	wire [7:0] Bcdsec, Bcdmin, Bcdhr;


clock the_clk(
	.clk(clk), .rst(rst),
	.kHr(kHr), .kMin(kMin), .kSec(kSec),
	.Sec(Sec), .Min(Min), .Hr(Hr)
);


 keys the_keys(
	.key0(keySec),.key1(keyMin),.key2(keyHr),
	.k0(kSec),.k1(kMin),.k2(kHr),
	.clk(clk)
);

Bin2Bcd the_sec(
	.clk(clk),
	.Bin(Sec),//0~99
	.Bcd(Bcdsec)
);


Bin2Bcd the_min(
	.clk(clk),
	.Bin(Min),//0~99
	.Bcd(Bcdmin)
);

Bin2Bcd the_hr(
	.clk(clk),
	.Bin(Hr),//0~99
	.Bcd(Bcdhr)
);

Bcd2Seg secL(
	.clk(clk),
	.Bcd(Bcdsec[3:0]),
	.Seg(secSegL)
);

Bcd2Seg secH(
	.clk(clk),
	.Bcd(Bcdsec[7:4]),
	.Seg(secSegH)
);

Bcd2Seg minL(
	.clk(clk),
	.Bcd(Bcdmin[3:0]),
	.Seg(minSegL)
);

Bcd2Seg minH(
	.clk(clk),
	.Bcd(Bcdmin[7:4]),
	.Seg(minSegH)
);

Bcd2Seg hrL(
	.clk(clk),
	.Bcd(Bcdsec[3:0]),
	.Seg(hrSegL)
);

Bcd2Seg hrH(
	.clk(clk),
	.Bcd(Bcdsec[7:4]),
	.Seg(hrSegH)
);
endmodule
