
`default_nettype none
module Counter #(parameter M = 100)(
    input wire clk, rst, en,
    output logic [$clog2(M) - 1 : 0] cnt,
    output logic co
);
    always_ff@(posedge clk) begin
        if(rst) cnt <= '0;
        else if(en) begin
            if(cnt < M - 1) cnt <= cnt + 1'b1;
            else cnt <= '0;
        end
    end
    assign co = en & (cnt == M - 1);
endmodule

module ADS8865 #(
    parameter HBDIV = 4, // 1sck==8clk
    parameter BITS = 16
)(
    input wire clk, rst, start,
    input wire  sdi,
    output logic busy = '0,
    output logic sck, cs,
    output logic unsigned[BITS - 1 : 0]data
);
    logic hbr_co, hbc_co;
    logic [$clog2((BITS * 2)+1) - 1 : 0] hbc_cnt;
    Counter #(HBDIV) hbRateCnt(clk, rst, busy, , hbr_co);
    Counter #((BITS * 2)+1) hbCnt(clk, rst, hbr_co, hbc_cnt, hbc_co);
    always_ff@(posedge clk)
    begin
        if(start) busy <= 1'b1;
        else if(hbc_co) busy <= 1'b0;
    end
    logic [BITS - 1 : 0] shifter = '0;
    always_ff@(posedge clk) begin
        if(rst) shifter <= '0;
        else if(start) data <= shifter;
        else if(hbr_co & hbc_cnt[0]) begin 
			   shifter <= shifter << 1;
			   shifter[0] <= sdi;
			  end
    end
    always@(*)begin
	  sck <= busy & hbc_cnt[0];
      cs <= ~busy;	
    end	
endmodule