module dds #( 
	parameter PHASE_W = 24, 
	parameter DATA_W = 12, 
	parameter TABLE_AW = 12,
	parameter MEM_FILE = "SineTable.dat"
)( 
	input [PHASE_W - 1 : 0] FreqWord, 
	input [PHASE_W - 1 : 0] PhaseShift,
	input clk, 
	input ClkEn, 
	output reg signed [DATA_W - 1 : 0] Out
) ;
   	reg signed [DATA_W - 1 : 0] sinTable[2 ** TABLE_AW - 1 : 0]; // Sine table ROM
   	reg [PHASE_W - 1 : 0] phase; // Phase Accumulater
   	wire [PHASE_W - 1 : 0] addr = phase + PhaseShift; // Phase Shift

initial begin
   	   phase = 0;
   	   $readmemh(MEM_FILE, sinTable); // Initialize the ROM
end

always@(posedge clk) begin
      if(ClkEn) phase <= phase + FreqWord;
   end
   
always@(posedge clk) begin
      Out <= sinTable[addr[PHASE_W - 1 : PHASE_W - TABLE_AW]]; // Look up the table
   end


endmodule 