
`timescale 1ns/1ps
module tb;
reg clk;
wire clk_2M;

initial clk = 'b0;
always #5 clk = ~clk;


FretoFre the_clk_2M(  
    .clk(clk),  
    .rst_n(1'b1),  
  
    .clk_2M(clk_2M)//,  
//    output      reg         [4:0]               Count  
);



endmodule 