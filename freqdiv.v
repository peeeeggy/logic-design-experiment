`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/11 00:29:28
// Design Name: 
// Module Name: freq_div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module freq_div(clk,rst,clk_1,clk_10,clk_25M);
input clk, rst;
output clk_1, clk_10; // clk_1 for clk_ctl, clk_10 for  sound
output clk_25M; // for vga

reg [25:0] tmp,tmp1,tmp2;
reg clk_1_tmp, clk_10_tmp;
reg [24:0] clk_25M_tmp;

always@(posedge clk or posedge rst)
if(rst)
begin
    tmp <= 0;
    clk_1_tmp <= 0;   
end
else if (tmp == 26'd49999999) 
    begin
        clk_1_tmp <= ~clk_1_tmp;
        tmp <= 0;
    end
else tmp <= tmp + 26'd1;

always@(posedge clk or posedge rst)
if(rst)
begin
    tmp1 <= 0;
    clk_10_tmp <= 0;   
end
else if (tmp1 == 26'd4999999) 
    begin
        tmp1 <= 0;
        clk_10_tmp <= ~clk_10_tmp;
    end
else tmp1 <= tmp1 + 26'd1;

always@(posedge clk or posedge rst)
if(rst)
begin
    tmp2 <= 0;
    clk_25M_tmp <= 0;   
end
else if (tmp2 == 26'd2) 
    begin
        tmp2 <= 0;
        clk_25M_tmp <= ~clk_25M_tmp;
    end
else tmp2 <= tmp2 + 26'd1;

assign clk_1 = clk_1_tmp;
assign clk_10 = clk_10_tmp;
assign clk_25M = clk_25M_tmp;

endmodule
    
