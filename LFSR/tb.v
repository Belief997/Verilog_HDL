`timescale 1ns/1ps
module tb;
	reg clk;
	wire noise1;
	wire noise2;
	wire noise3;
	wire [11:0] out;
	wire [11:0] Seg;

initial begin clk = 1'b0; end

always begin
//	#765 clk = ~clk;//100M / 153
	#5 clk = ~clk;//100M / 200k
end

//reg [31:0] a;  
//reg [31:0] b;  
//wire [31:0] c; 
//
//initial  
//begin  
//    #10 a = $random()%10000;  
//        b = $random()%1000;  
//          
////    #100 a = $random()%1000;  
////        b = $random()%100;  
////          
////    #100 a = $random()%100;  
////        b = $random()%10;     
//          
////    #1000 $stop;  
//end 
//always begin
//    #100 a = $random()%1000;  
//        b = $random()%100;
//    #50 a = $random()%100;  
//        b = $random()%10;  
//end
//


 top the_top(
	.clk(clk),
	.noise1(noise1),
	.noise2(noise2),
	.noise3(noise3),
	.out(out),
	.Seg(Seg)
);

//divider#(.W1(32), .W2(32)) the_divider(
//	.clk(clk),
//	.a(a),//divided,
//	.b(b),//divider,
//	.c(c)//quotient
//
//);



endmodule 