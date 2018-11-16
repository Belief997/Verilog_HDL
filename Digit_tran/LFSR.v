//W is the highest pow 
//MASK :  its LSB is not cared 
module LFSR#( parameter W = 8, parameter [W:0] MASK = 32'h11c //, parameter WO = W
)(
	input clk, clken,
	output reg [W - 1 : 0] lfsr
);
	initial lfsr = 'b1;

	always@(posedge clk)begin
		if(clken)begin
			if(lfsr[0]) lfsr <= (lfsr >> 1) ^ (MASK >> 1);
			else lfsr <= (lfsr >> 1);
		end
	end
endmodule 


module LFSR_w #(  
    parameter W = 8,
    parameter POLY = 9'h11D)
(   input clk,
    input arst,
    input en,
    output out
);
    reg [W-1:0] sreg=1;
    assign out = sreg[0];
    always@(posedge clk or posedge arst) begin
        if(arst) sreg <= 1'b1;
        else begin
            if(en) begin
                if(out) sreg <= (sreg >> 1) ^ (POLY >> 1);
                else sreg <= sreg >> 1;
            end
        end
    end
endmodule 