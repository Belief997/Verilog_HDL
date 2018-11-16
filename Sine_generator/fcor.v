
module fcor(
	input clk,
	input [15:0] fdata,
	input fclk, fcs,
	input [1:0] fmod

);
	reg [15:0] fdata_reg; initial fdata_reg = 'b0;
	always@(posedge clk) fdata_reg <= fdata;

	reg [1:0] fclk_dly;
	initial fclk_dly = 'b0;
	always@(posedge clk)begin
		fclk_dly[1] <= fclk_dly[0];
		fclk_dly[0] <= fclk;
	end
	wire fclk_fall = ( fclk_dly== 2'b10);

	reg [1:0] fcs_dly;
	initial fcs_dly = 'b0;
	always@(posedge clk)begin
		fcs_dly[1] <= fcs_dly[0];
		fcs_dly[0] <= fcs;
	end
	wire fcs_up = ( fcs_dly== 2'b01);

	reg [1:0] fmod_reg;initial fmod_reg = 'b0;
	always@(posedge clk)begin
		if(~fcs & fclk)
			fmod_reg <= fmod;
	end

	reg [15:0] flag_mod_temp;
	reg [31:0] Freq_temp;
	initial begin flag_mod_temp = 'b0; Freq_temp = 'b0; end
	always@(posedge clk)begin
		if(~fcs & fclk_fall)begin
			if(fmod_reg == 2'b01)	flag_mod_temp <= fdata_reg;
			else if(fmod_reg == 2'b11) Freq_temp[31:16] <= fdata_reg;
			else if(fmod_reg == 2'b10) Freq_temp[15:0] <= fdata_reg;
			else Freq_temp <= Freq_temp;
		end
	end
	
	reg [15:0] flag_mod;
	reg [31:0] Freq;
	initial begin flag_mod = 'b0; Freq = 'b0; end
	always@(posedge clk)begin
		if(fcs_up)begin
			flag_mod <= flag_mod_temp;
			Freq <= Freq_temp;
		end
	end


endmodule
