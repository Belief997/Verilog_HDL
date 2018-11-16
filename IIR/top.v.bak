
module top(
	input clk,
	input signed [11:0] in,
	output unsigned [15:0] out

);


reg signed [31:0] the_in;//= 2'sb1 * in;
wire signed [31:0] iir_out;
reg [19:0] cnt1000;
wire co;
initial begin cnt1000 = 20'b0;  the_in = 'd0; end

//always @(posedge clk)begin
//    if(cnt1000 < 20'd100_000) cnt1000<=cnt1000+1'b1;
//    else cnt1000 <= 20'd0;
//end
//assign co = (cnt100)


assign out = iir_out + 16'd4096;

always@(posedge clk)begin
//if(cnt1000 == 20'd100_000)
the_in = 2'sb1 * in;
end





 my_iir the_iir(
	.clk(clk),//.en(en),
	.in(the_in),
	.out(iir_out)

);










endmodule 