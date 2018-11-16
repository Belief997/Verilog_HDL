
module get_exp_shift(
	input clk, rst_n,
	input signed [15:0] x, x_shift,
	output [45:0] y  //Q23.23

);
	localparam N1 = 46'sd1; //x + ni...
	localparam Y1 = 23;     //y - (y >>> Yi)
	localparam N2 = 46'sd2;
	localparam Y2 = 22;
	localparam N3 = 46'sd4;
	localparam Y3 = 21;
	localparam N4 = 46'sd8;
	localparam Y4 = 20;
	localparam N5 = 46'sd16;
	localparam Y5 = 19;
	localparam N6 = 46'sd32;
	localparam Y6 = 18;
	localparam N7 = 46'sd64;
	localparam Y7 = 17;
	localparam N8 = 46'sd128;
	localparam Y8 = 16;
	localparam N9 = 46'sd256;
	localparam Y9 = 15;
	localparam N10 = 46'sd512;
	localparam Y10 = 14;
	localparam N11 = 46'sd41024;
	localparam Y11 = 13;
	localparam N12 = 46'sd2048;
	localparam Y12 = 12;
	localparam N13 = 46'sd4097;
	localparam Y13 = 11;
	localparam N14 = 46'sd8196;
	localparam Y14 = 10;
	localparam N15 = 46'sd16400;
	localparam Y15 = 9;
	localparam N16 = 46'sd32832;
	localparam Y16 = 8;
	localparam N17 = 46'sd65793;
	localparam Y17 = 7;
	localparam N18 = 46'sd132106;
	localparam Y18 = 6;
	localparam N19 = 46'sd266327;
	localparam Y19 = 5;
	localparam N20 = 46'sd541388;
	localparam Y20 = 4;
	localparam N21 = 46'sd1_120_142;
	localparam Y21 = 3;
	localparam N22 = 46'sd2_413_252;
	localparam Y22 = 2;
	localparam N23 = 46'sd5_814_539;
	localparam Y23 = 1;     //1/2
	localparam N24 = 46'sd5_814_539; //
	localparam Y24 = 1;     // y >>> Yi
	localparam N25 = 46'sd1_162_907_9;
	localparam Y25 = 2;
	localparam N26 = 46'sd1_744_361_9;
	localparam Y26 = 3;
	localparam N27 = 46'sd2_325_815_9;
	localparam Y27 = 4;
	localparam N28 = 46'sd2_907_269_9;
	localparam Y28 = 5;
	localparam N29 = 46'sd3_488_723_9;
	localparam Y29 = 6;

	reg [45:0] x0, y0; initial begin x0 = 'b0; y0 = 'b1 <<< 23; end
	always@(posedge clk)begin
		if(x_shift <= 16'sd23) x0 <= x <<< (16'sd23 - x_shift);
		else x0 <= x >>> (x_shift - 16'sd23);
	end

wire [45:0] x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7,x8,y8,x9,y9,x10,y10;
wire [45:0] x11,y11,x12,y12,x13,y13,x14,y14,x15,y15,x16,y16,x17,y17,x18,y18,x19,y19,x20,y20;
wire [45:0] x21,y21,x22,y22,x23,y23,x24,y24,x25,y25,x26,y26,x27,y27,x28,y28,x29,y29;
assign y = y1;

Shift_add_0#( 
	.N(N1), .Y(Y1)
) sec1(
	.clk(clk), .rst_n(rst_n),
	.x_in(x2), .y_in(y2),
	.x_out(x1), .y_out(y1)
);
Shift_add_0#( 
	.N(N2), .Y(Y2)
) sec2(
	.clk(clk), .rst_n(rst_n),
	.x_in(x3), .y_in(y3),
	.x_out(x2), .y_out(y2)
);
Shift_add_0#( 
	.N(N3), .Y(Y3)
) sec3(
	.clk(clk), .rst_n(rst_n),
	.x_in(x4), .y_in(y4),
	.x_out(x3), .y_out(y3)
);
Shift_add_0#( 
	.N(N4), .Y(Y4)
) sec4(
	.clk(clk), .rst_n(rst_n),
	.x_in(x5), .y_in(y5),
	.x_out(x4), .y_out(y4)
);
Shift_add_0#( 
	.N(N5), .Y(Y5)
) sec5(
	.clk(clk), .rst_n(rst_n),
	.x_in(x6), .y_in(y6),
	.x_out(x5), .y_out(y5)
);
Shift_add_0#( 
	.N(N6), .Y(Y6)
) sec6(
	.clk(clk), .rst_n(rst_n),
	.x_in(x7), .y_in(y7),
	.x_out(x6), .y_out(y6)
);
Shift_add_0#( 
	.N(N7), .Y(Y7)
) sec7(
	.clk(clk), .rst_n(rst_n),
	.x_in(x8), .y_in(y8),
	.x_out(x7), .y_out(y7)
);
Shift_add_0#( 
	.N(N8), .Y(Y8)
) sec8(
	.clk(clk), .rst_n(rst_n),
	.x_in(x9), .y_in(y9),
	.x_out(x8), .y_out(y8)
);
Shift_add_0#( 
	.N(N9), .Y(Y9)
) sec9(
	.clk(clk), .rst_n(rst_n),
	.x_in(x10), .y_in(y10),
	.x_out(x9), .y_out(y9)
);
Shift_add_0#( 
	.N(N10), .Y(Y10)
) sec10(
	.clk(clk), .rst_n(rst_n),
	.x_in(x11), .y_in(y11),
	.x_out(x10), .y_out(y10)
);

Shift_add_0#( 
	.N(N11), .Y(Y11)
) sec11(
	.clk(clk), .rst_n(rst_n),
	.x_in(x12), .y_in(y12),
	.x_out(x11), .y_out(y11)
);
Shift_add_0#( 
	.N(N12), .Y(Y12)
) sec12(
	.clk(clk), .rst_n(rst_n),
	.x_in(x13), .y_in(y13),
	.x_out(x12), .y_out(y12)
);
Shift_add_0#( 
	.N(N13), .Y(Y13)
) sec13(
	.clk(clk), .rst_n(rst_n),
	.x_in(x14), .y_in(y14),
	.x_out(x13), .y_out(y13)
);
Shift_add_0#( 
	.N(N14), .Y(Y14)
) sec14(
	.clk(clk), .rst_n(rst_n),
	.x_in(x15), .y_in(y15),
	.x_out(x14), .y_out(y14)
);
Shift_add_0#( 
	.N(N15), .Y(Y15)
) sec15(
	.clk(clk), .rst_n(rst_n),
	.x_in(x16), .y_in(y16),
	.x_out(x15), .y_out(y15)
);
Shift_add_0#( 
	.N(N16), .Y(Y16)
) sec16(
	.clk(clk), .rst_n(rst_n),
	.x_in(x17), .y_in(y17),
	.x_out(x16), .y_out(y16)
);
Shift_add_0#( 
	.N(N17), .Y(Y17)
) sec17(
	.clk(clk), .rst_n(rst_n),
	.x_in(x18), .y_in(y18),
	.x_out(x17), .y_out(y17)
);
Shift_add_0#( 
	.N(N18), .Y(Y18)
) sec18(
	.clk(clk), .rst_n(rst_n),
	.x_in(x19), .y_in(y19),
	.x_out(x18), .y_out(y18)
);
Shift_add_0#( 
	.N(N19), .Y(Y19)
) sec19(
	.clk(clk), .rst_n(rst_n),
	.x_in(x20), .y_in(y20),
	.x_out(x19), .y_out(y19)
);
Shift_add_0#( 
	.N(N20), .Y(Y20)
) sec20(
	.clk(clk), .rst_n(rst_n),
	.x_in(x21), .y_in(y21),
	.x_out(x20), .y_out(y20)
);

Shift_add_0#( 
	.N(N21), .Y(Y21)
) sec21(
	.clk(clk), .rst_n(rst_n),
	.x_in(x22), .y_in(y22),
	.x_out(x21), .y_out(y21)
);
Shift_add_0#( 
	.N(N22), .Y(Y22)
) sec22(
	.clk(clk), .rst_n(rst_n),
	.x_in(x23), .y_in(y23),
	.x_out(x22), .y_out(y22)
);
Shift_add_0#( 
	.N(N23), .Y(Y23)
) sec23(
	.clk(clk), .rst_n(rst_n),
	.x_in(x24), .y_in(y24),
	.x_out(x23), .y_out(y23)
);
Shift_add_1#( 
	.N(N24), .Y(Y24)
) sec24(
	.clk(clk), .rst_n(rst_n),
	.x_in(x25), .y_in(y25),
	.x_out(x24), .y_out(y24)
);
Shift_add_1#( 
	.N(N25), .Y(Y25)
) sec25(
	.clk(clk), .rst_n(rst_n),
	.x_in(x26), .y_in(y26),
	.x_out(x25), .y_out(y25)
);
Shift_add_1#( 
	.N(N26), .Y(Y26)
) sec26(
	.clk(clk), .rst_n(rst_n),
	.x_in(x27), .y_in(y27),
	.x_out(x26), .y_out(y26)
);
Shift_add_1#( 
	.N(N27), .Y(Y27)
) sec27(
	.clk(clk), .rst_n(rst_n),
	.x_in(x28), .y_in(y28),
	.x_out(x27), .y_out(y27)
);
Shift_add_1#( 
	.N(N28), .Y(Y28)
) sec28(
	.clk(clk), .rst_n(rst_n),
	.x_in(x29), .y_in(y29),
	.x_out(x28), .y_out(y28)
);
Shift_add_1#( 
	.N(N29), .Y(Y29)
) sec29(
	.clk(clk), .rst_n(rst_n),
	.x_in(x0), .y_in(y0),
	.x_out(x29), .y_out(y29)
);









endmodule 


module Shift_add_0#( 
parameter N = 1, parameter Y = 0
)(
	input clk, rst_n,
	input signed [45:0] x_in, y_in,
	output reg [45:0] x_out, y_out
);
	initial begin y_out = 'b1 <<< 23; x_out = 'b0; end
	always@(posedge clk)begin
	    if(~rst_n)begin
		x_out <= 'b0;
		y_out <= 'b1;
	    end else begin
		if((x_in + N) <= 46'sb0)begin
			x_out <= x_in + N;
			y_out <= y_in - (y_in >>> Y);
		end 
		else begin
			x_out <= x_in;
			y_out <= y_in;
		end 
	    end
	end
endmodule 

module Shift_add_1#( 
parameter N = 1, parameter Y = 0
)(
	input clk, rst_n,
	input signed [45:0] x_in, y_in,
	output reg [45:0] x_out, y_out
);
	initial begin y_out = 'b1 <<< 23; x_out = 'b0; end
	always@(posedge clk)begin
	    if(~rst_n)begin
		x_out <= 'b0;
		y_out <= 'b1;
	    end else begin
		if((x_in + N) <= 46'sb0)begin
			x_out <= x_in + N;
			y_out <= y_in >>> Y;
		end 
		else begin
			x_out <= x_in;
			y_out <= y_in;
		end 
	    end
	end
endmodule 