
module dds_to_fb
#( 	parameter PHASE_W = 24,
	parameter DATA_W = 12, 
	parameter TABLE_AW = 12,
   	parameter MEM_FILE = "SineTable.dat"
)( 	input wire [PHASE_W - 1 : 0] FreqWord, FreqWord_3, FreqWord_5, 
   	input wire Clock,
	output reg   Out_1, Out_3, Out_5,
	input wire k0,k1,k2,k3,k4,k5	

) ; 

	reg [PHASE_W - 1 : 0] PhaseShift, PhaseShift_3, PhaseShift_5;
	reg signed [DATA_W - 1 : 0] sinTable[2 ** TABLE_AW - 1 : 0]; // Sine table ROM
	reg  [PHASE_W - 1 : 0] phase, phase_3, phase_5; // Phase Accumulater
	wire [PHASE_W - 1 : 0] addr = phase + PhaseShift; 
	wire [PHASE_W - 1 : 0] addr_3 = phase_3 + PhaseShift_3;
	wire [PHASE_W - 1 : 0] addr_5 = phase_5 + PhaseShift_5;// Phase Shift
   initial begin
	phase = 0;
	phase_3 = 0;
	phase_5 = 0;
	PhaseShift = 0;
	PhaseShift_3 = 0; 
	PhaseShift_5 = 0;
	$readmemh(MEM_FILE, sinTable); // Initialize the ROM
   end

	always@(k0|k1|k2|k3|k4|k5)  begin
	if(k0)  PhaseShift = PhaseShift - 24'd7_001_100;//24'h100_0000
	if(k1)  PhaseShift = PhaseShift + 24'h60_0000;
	if(k2)  PhaseShift_3 = PhaseShift_3 - 24'd7001100;
	if(k3)  PhaseShift_3 = PhaseShift_3 + 24'd7001100;
	if(k4)  PhaseShift_5 = PhaseShift_5 - 24'd7001100;
	if(k5)  PhaseShift_5 = PhaseShift_5 + 24'd7001100;
	end

   always@(posedge Clock) begin
      phase <= phase + FreqWord;
   end
   always@(posedge Clock) begin
      Out_1 <= sinTable[addr[PHASE_W - 1 : PHASE_W - TABLE_AW]] >>11; // Look up the table
   end


   always@(posedge Clock) begin
      phase_3 <= phase_3 + FreqWord_3;
   end
   always@(posedge Clock) begin
      Out_3 <= sinTable[addr_3[PHASE_W - 1 : PHASE_W - TABLE_AW]] >>11; // Look up the table
   end


   always@(posedge Clock) begin
      phase_5 <= phase_5 + FreqWord_5;
   end
   always@(posedge Clock) begin
      Out_5 <= sinTable[addr_5[PHASE_W - 1 : PHASE_W - TABLE_AW]] >>11; // Look up the table [23:12]
   end



endmodule