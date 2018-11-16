module clock(
	input clk, rst,
	input kHr, kMin, kSec,
	output reg [6:0] Hr, Min, Sec
);

	reg [9:0] cnt_1s;
	wire co_1s;
initial cnt_1s = 10'b0;
assign co_1s = (cnt_1s == 10'd999);
always @(posedge clk or posedge rst) begin
	if (rst) cnt_1s <= 10'b0;
	else begin
	if (cnt_1s < 10'd999)	cnt_1s <= cnt_1s + 10'b1;
	else cnt_1s <= 10'b0;
	end
end

	reg Sflg;
	wire co_sec;
initial Sec = 6'b0;
assign co_sec = ((Sec == 6'd0) && (Sflg == 0));
always @(posedge co_1s or posedge kSec or posedge rst) begin
	if(rst) Sec <= 6'b0;
	else begin
	if(Sec < 6'd59) begin 
	Sec <= Sec + 6'b1;
	Sflg <= 0;
	end
	else  begin
	Sec <= 6'b0;
	Sflg = kSec ? 1 : 0;
	end
	end
end


	reg Mflg;
	reg [5:0] cnt_min;
	wire co_min;
initial Min = 6'b0;
assign co_min = ((Min == 6'd0) && ( Mflg == 0));
always @(posedge co_sec or posedge kMin or posedge rst) begin
	if(rst) Min <= 6'b0;
	else begin
	if(Min < 6'd59) begin 
	Min <= Min + 6'b1;
	Mflg <= 0;
	end
	else begin 
	Min <= 6'b0;
	Mflg = kMin ? 1 : 0;
	end	
	end
end


	reg Hflg;
	wire co_hr;
initial	Hr = 5'b0;
assign co_hr = ((Hr == 5'd0) && (Hflg == 0));
always @(posedge co_min or posedge kHr or posedge rst) begin
	if(rst) Hr <= 5'b0;
	else begin
	if (Hr < 5'd23) begin 
	Hr <= Hr + 5'b1;
	Hflg <= 0;
	end
	else begin 
	Hr <= 5'b0;
	Hflg = kHr ? 1:0;
	end 
	end
end


endmodule 
