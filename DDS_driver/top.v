
module top(
	input clk, //rst_n
	output  SCLK, CS, PWD, RST, UP,
	output  SD0, SD1, SD2, SD3,
	output  P0, P1, P2, P3,

	input key0,
    	output reg[2:0] flag//8 debug states
);

	reg [31:0] Frq0, Frq1, Frq2, Frq3;
	reg [15:0] Phase0, Phase1, Phase2, Phase3;
	reg [23:0] Amp0, Amp1, Amp2, Amp3;
//	wire SCLK, CS, PWD, RST, UP, SD0, SD1, SD2, SD3, P0, P1, P2, P3;
	


//initial begin
//	Frq0 = 32'hb000_a5a5; Frq1 = 32'hb000_a5a5; Frq2 = 32'hb000_a5a5;Frq3 = 32'hb000_a5a5;
//	Phase0 = 16'ha5a5; Phase1 = 16'ha5a5;Phase2 = 16'ha5a5;Phase3 = 16'ha5a5;
//	Amp0 = 24'b0; Amp1 = 24'b0;Amp2 = 24'b0;Amp3 = 24'b0;
////	#3635 Phase3 = 16'ha5a6;
//end

initial begin
	Frq0 = 32'd33; Frq1 = 32'd98; Frq2 = 32'd164;Frq3 = 32'd164;
	Phase0 = 16'd0; Phase1 = 16'd0;Phase2 = 16'd0;Phase3 = 16'd8192;
	Amp0 = 24'b0; Amp1 = 24'b0;Amp2 = 24'b0;Amp3 = 24'b0;
//	#3635 Phase3 = 16'ha5a6;
end

////////////////////////////////////////////////////////////////////////
wire k0;
reg [15:0] temp;//changeable output , adjust width and type   
initial begin flag = 'b0; temp = 'b0; end 
always@(posedge clk)begin
    if(k0)begin
    if(flag != 3'd2)  flag <= flag + 2'b1;
    else if(flag == 3'd2)   flag <= 3'd0;
    end
end
always@(posedge clk) begin
    case(flag)
        3'd0:begin
            Frq0 = 32'd33; Frq1 = 32'd33; Frq2 = 32'd164;Frq3 = 32'd164;
           end
        3'd1:begin
            Frq0 = 32'd98; Frq1 = 32'd98; Frq2 = 32'd164;Frq3 = 32'd164;
           end 
        3'd2:begin
            Frq0 = 32'd164; Frq1 = 32'd164; Frq2 = 32'd164;Frq3 = 32'd164;
           end
//        3'd3:begin
//            temp <= ;
//           end
//        3'd4:begin
//            temp <= ;
//           end  
//        3'd5:begin
//            temp <= ;
//            end
        default: begin
           Frq0 = 32'd33; Frq1 = 32'd33; Frq2 = 32'd164;Frq3 = 32'd164;
        end
    endcase
end


 keys the_key(
	.clk(clk),
	.key0(key0),//key1,key2,
	.k0(k0)//,k1,k2

);
//////////////////////////////////////////////



DDS_driver the_ad9959(
	.clk(clk), .rst_n(1'b1),
	.Frq0(Frq0), .Frq1(Frq1), .Frq2(Frq2), .Frq3(Frq3),
	.Phase0(Phase0), .Phase1(Phase1), .Phase2(Phase2), .Phase3(Phase3),//16bit = 00+14bit phase
	.Amp0(Amp0), .Amp1(Amp1), .Amp2(Amp2), .Amp3(Amp3),
	.SCLK(SCLK), .CS(CS), .PWD(PWD), .RST(RST), .UP(UP),
	.SD0(SD0), .SD1(SD1), .SD2(SD2), .SD3(SD3),
	.P0(P0), .P1(P1), .P2(P2), .P3(P3)
);
endmodule 