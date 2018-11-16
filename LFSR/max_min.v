
module max_min(
	input clk,
	input [11:0] data,
	output reg [11:0] out 
);
reg [11:0] dataTemp[0:1023], max, min, aver;
reg [31:0] dataSum;
reg [11:0] datain;

initial begin
//	dataTemp[*] = 'b0;
	dataSum = 'b0;
	max = 'b0;
	min = 'd999;
	aver = 'b0;
	out = 'b0;
	datain = 'b0;
end

////update timer 10ms
//reg [19:0] cnt10ms;
//wire updata = (cnt10ms == 1_000_000);
//initial cnt10ms = 'b0;
//always @(posedge clk) begin
//	if(cnt10ms < 1_000_000)	cnt10ms <= cnt10ms + 1'b1;
//	else cnt10ms <= 'b0;
//end
//
//always@(posedge clk) begin
//	dataTemp <= data;
//	differ <= max - min;
//	if(updata)begin	max <= 'b0;	min <= 'd999;	end
//	else if(dataTemp > max)	max <= dataTemp;
//	else if(dataTemp < min)	min <= dataTemp;
//	else begin end
//end

reg [31:0] cnttri;
reg [11:0] data_reg[0:1];
wire cotri = (cnttri == 32'd100_000);//1ms 
reg flag;
initial begin cnttri = 'b0; data_reg[0] = 'b0; data_reg[1] = 'b0; flag = 'b0;end
always@(posedge clk)begin
	if(cnttri != 32'd100_000) 	cnttri <= cnttri + 1'd1;
	else cnttri <= 'd0;
end
always@(posedge clk)begin
	if(cotri) begin
	data_reg[1] <= data_reg[0];
	data_reg[0] <= datain;
	
	end
	if((data_reg[0] < data_reg[1])&((data_reg[1] - data_reg[0]) >= 12'd150))
	flag = 1'b1;
	else if((data_reg[0] > data_reg[1])&((data_reg[0] - data_reg[1]) >= 12'd150))
	flag = 1'b0;
end






integer i;
initial i = 24'b0;

reg [31:0] cntsmp;//260us
reg [31:0] cnt1s;
wire co = (cntsmp == 32'd97);
initial cntsmp = 'b0;
always @(posedge clk) begin
	if(flag)begin
	if(cntsmp < 32'd97)	cntsmp <= cntsmp + 1'b1;
	else cntsmp <= 'b0;
	end
end

initial cnt1s = 'b0;
always@(posedge co)begin
	if(cnt1s != 32'd1024 )	cnt1s <= cnt1s + 1'b1;
	else cnt1s <= 32'd1024;
end

always@(posedge co)begin 
	if(i != 24'd1023)
	i <= i +  24'b1;
	else i <= 'b0;
end
always @(posedge co) begin
	if(i != 1023)begin
		dataTemp[i] <= data;

 	end
//end
//always@(posedge clk)begin
	if((i == 1023)&(cnt1s <= 32'd1024))	begin aver <= (dataSum >>10); dataSum <= 'b0; end
	else 		dataSum  <= dataSum + dataTemp[i];
end




always@(posedge clk)begin
	out <= max;
end







endmodule 