module top(
	input clk, nrst,//when put into vivado, remember to remove the port 'nrst'
	output  CS, CLK, SDI

);

//	wire [15:0] data = 16'h55AA;
    wire signed [15:0] sin;
	wire signed [15:0] data ;
	reg [23:0] freq = 24'd1678;
	wire [23:0] phaseShift = 24'b0;

    assign data = 18'd1*sin+18'd32768;

 
dac_driver dac8811(
	.clk(clk), .nrst(nrst),
	.data(data),
	.CS(CS), .CLK(CLK), .SDI(SDI)

);

    dds #( 
	.PHASE_W (24), 
	.DATA_W (16), 
	.TABLE_AW  (8),
	.MEM_FILE  ("SinTable256X16.dat")
) dds_inst (
       .FreqWord(freq),
       .PhaseShift(phaseShift),
       .clk(clk),
       .ClkEn(1'b1),
       .Out(sin)) ;

endmodule 





