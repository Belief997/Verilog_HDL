
module fpmul(  
    input [31:0] mdat1,  
    input [31:0] mdat2,  
    output [31:0] odat,  
    input clk,  
    input rst_n  
);  
  
reg s1,s2;  
reg [7:0] e1,e2;  
reg [8:0] x3,x4,y3,y4;  
reg [4:0] x2,y2;  
  
always @(posedge clk or negedge rst_n) begin  
    if(~rst_n) begin  
        {s1,e1,x3,x4,x2}<=32'd0;  
        {s2,e2,y3,y4,y2}<=32'd0;  
    end else begin  
        {s1,e1,x3,x4,x2}<=mdat1; //?????  
        {s2,e2,y3,y4,y2}<=mdat2; //?????   
    end  
end  
// clk1  
reg s3;  
reg s3_b1,s3_b2,s3_b3,s3_b4;//pipeline????  
  
reg [8:0] adde;  
reg [7:0] adde_b1,adde_b2,adde_b3,adde_b4;//pipeline????  
  
reg [35:0] mul1; //??????  
reg [13:0] mul2,mul3;  
reg [23:0] addxy1;  
//clk2  
reg [22:0] mul1_b1;  
reg [14:0] addm1;  
reg [33:0] addm2;  
//clk3  
reg [33:0] addm3;  
//clk4  
reg [33:0] addm4;  
//clk5  
reg [22:0] addm5;  
//output signal  
assign odat={s3_b4,adde_b4,addm5};  
  
always @(posedge clk or negedge rst_n) begin  
    if(~rst_n) begin  
        //  
    end else begin  
        //clk1  
        s3<=s1^s2;  
        adde<=e1+e2;  
        mul1<={x3,x4}*{y3,y4};  
        mul2<=x3*y2;  
        mul3<=y3*x2;  
        addxy1<={x3,x4,x2}+{y3,y4,y2};  
  
        //clk2  
        s3_b1<=s3;  
        adde_b1<=adde-9'd127;  
        addm1<=mul2+mul3;  
        addm2<=mul1[35:4]+{addxy1,9'b0}; //23bits,?? //????????????,????????9?????  
        //clk3  
        s3_b2<=s3_b1;      
        adde_b2<=adde_b1;  
        addm3<=addm2+addm1[14:0];//??  
        //clk4  
        s3_b3<=s3_b2;  
        adde_b3<=adde_b2;  
        addm4<=addm3+{1'b1,23'd0,9'b0};  
        //clk5  
        s3_b4<=s3_b3;  
        if(addm4[33])begin //??????????:1.x*1.y??????1,????4?????  
            addm5<=addm4[32:10];  
            adde_b4<=adde_b3+8'd1;  
        end else begin  
            addm5<=addm4[31:9];  
            adde_b4<=adde_b3;  
        end  
    end  
end  
  
endmodule 