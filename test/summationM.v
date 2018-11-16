module summationM #(

    parameter M

)(

    input clk,

    input arst,

    input signed [10:0] addend,

    output reg signed [Log2(M-1) + 1 : 0] cnt,

    output cop,

    output con

);



    function integer Log2(input integer x);

        for(Log2 = 0; x > 1; x = x >> 1)

            Log2 = Log2 + 1;

    endfunction



    initial begin

        cnt = 11'sd994;

    end



    assign cop = (cnt + addend > M - 1);

    assign con = (cnt + addend < 'sb0);



    always@(posedge clk or posedge arst) begin

        if(arst) cnt <= 0;

        else begin

            if(addend >= 'sb0) begin

                if(~cop)

                    cnt <= cnt + addend;

                else

                    cnt <= cnt + addend - M;

            end

            else begin

                if(~con)

                    cnt <= cnt + addend;

                else

                    cnt <= M + addend + cnt;

            end

        end

    end



endmodule
