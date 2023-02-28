`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/11 01:01:57
// Design Name: 
// Module Name: speed
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


module speed(clk,clk_10,rst,level1,level2,level3,speed,led);
input clk, rst;
input clk_10;
input level1,level2,level3;
output reg [9:0] speed; // 9 decide by √‰¨…(discuss whether to change or not)
output reg [3:0] led;

reg [1:0] lv;

always @(posedge clk_10 or posedge rst)
if (rst)
    lv <= 2'd0;
else if (level3)
    lv <= 2'd3;
else if (level2)
    lv <= 2'd2;
else if (level1)
    lv <= 2'd1;   
    
always @(posedge clk or posedge rst)
if (rst)
    led <= 4'd0;
else if (lv == 2'd0)
    led <= 4'b0001;
else if (lv == 2'd1)
    led <= 4'b0011;
else if (lv == 2'd2)
    led <= 4'b0111;
else if (lv == 2'd3)
    led <= 4'b1111;
    
always @(posedge clk or posedge rst)
if (rst)
    speed <= 0; 
else
    speed <= lv + 9'd10; // 9 need to be discussed  

endmodule

