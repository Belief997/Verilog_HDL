`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:06:58 09/25/2018
// Design Name:   manch_decoder
// Module Name:   F:/Xilinx/xilinx new project/manch/mach_decoder_testbench.v
// Project Name:  manch
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: manch_decoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mach_decoder_testbench;

	// Inputs
	reg clk;
	reg datamin;

	// Outputs
	wire databout;

	// Instantiate the Unit Under Test (UUT)
	manch_decoder uut (
		.clk(clk), 
		.datamin(datamin), 
		.databout(databout)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		datamin = 0;

		// Wait 100 ns for global reset to finish
		#100;
		always@(posedge clk)
         begin
		      datamin<=16'b0110_1100_1010_0101;
		// Add stimulus here

	end
      
endmodule

