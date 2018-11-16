`timescale 1ns/1ps

module summationM_tb;

    reg clk, arst;

    reg signed [10 : 0] addend;

    wire signed [10 : 0] cnt;

    wire cop, con;



    initial begin

        clk = 1'b0;

        arst = 1'b0;

        addend = 1'sb0;

    end



    always #10 clk = ~clk;



    always@(posedge clk) begin

        #5

        if(addend < 9)

            addend <= addend + 1;

        else

            addend <= -9;

    end



    summationM #( .M(1000) ) my_summation(

        .clk(clk),

        .arst(arst),

        .addend(addend),

        .cnt(cnt),

        .cop(cop),

        .con(con)

);



endmodule 
