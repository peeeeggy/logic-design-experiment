`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 23:35:38
// Design Name: 
// Module Name: random_point
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


module random_point(clk_vga,rst,rand_x,rand_y);
input clk_vga,rst;
output reg [9:0]rand_x;
output reg [9:0]rand_y;

reg [5:0]x_tmp,y_tmp;
initial begin
    x_tmp = 6'd10;
    y_tmp = 6'd10;
end

always@(posedge clk_vga or posedge rst)
if(rst) x_tmp <= 6'd0;
else x_tmp<= x_tmp + 6'd3;
always@(posedge clk_vga)
begin
    if(x_tmp>6'd61) rand_x <= 10'd610;
    else if(x_tmp<6'd3) rand_x <= 10'd30;
    else rand_x <= (x_tmp*10'd10);
end

always@(posedge clk_vga or posedge rst)
if(rst) y_tmp <= 6'd0;
else y_tmp<= y_tmp + 6'd1;
always@(posedge clk_vga)
begin
    if(y_tmp>6'd45) rand_y <= 10'd450;
    else if(y_tmp<6'd3) rand_y <= 10'd30;
    else rand_y <= (y_tmp*10'd10);
end

endmodule