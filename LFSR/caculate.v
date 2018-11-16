
module caculate(
	input clk,
	input [11:0] A1, A2,
	output reg [10:0] result

);
reg [11:0] A1temp, A2temp;
wire [13:0] R = 14'd10_000;
reg [25:0] A2R;
wire [10:0] Rx;

initial begin A1temp = 'b0; A2temp = 'b0; A2R = 'b1; result = 'b1; end

always@( A1 or A2) begin
	A1temp <= A1;
	A2temp <= A2;
	A2R <= A2temp * R; 
end
always@(posedge clk)begin
	result <= Rx;
end


divider#(.W1(26), .W2(26)) the_divider(
	.clk(clk),
	.a(A2R),//divided,
	.b(26'b1*(A1temp - A2temp)),//divider,
	.c(Rx)//quotient

);


endmodule 