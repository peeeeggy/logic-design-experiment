`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/18 09:39:47
// Design Name: 
// Module Name: note_gen
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

module note_generator(start,clk,rst,audio_left,audio_right,music,pitch);
input clk,rst;
input start;
input music;
input [21:0] pitch;
output [15:0] audio_left,audio_right;
reg [21:0] clk_cnt_next,clk_cnt;
reg b_clk,b_clk_next;
reg [15:0] audio_left_tmp,audio_right_tmp;

assign audio_left = audio_left_tmp;
assign audio_right = audio_right_tmp;

always@(posedge clk or posedge rst)
if(rst)
    begin
        clk_cnt <= 22'd0;
        b_clk <= 1'b0;
    end
else
    begin
        clk_cnt <= clk_cnt_next;
        b_clk<=b_clk_next;
    end

always@*
if(clk_cnt== pitch)
    begin
        clk_cnt_next = 22'd0;
        b_clk_next = ~b_clk;
    end
else 
    begin
        clk_cnt_next = clk_cnt+1'b1;
        b_clk_next = b_clk;
    end

always@(posedge clk or posedge rst)
if(rst || (~start)) 
    begin
        audio_left_tmp <= (b_clk == 1'b0)?(~16'h0000):(16'h0000);
        audio_right_tmp <= (b_clk == 1'b0)?(~16'h0000):(16'h0000);
    end 
else if(music) 
    begin
        audio_left_tmp <= (b_clk == 1'b0)?(~16'h77D0):(16'h77D0);
        audio_right_tmp <= (b_clk == 1'b0)?(~16'h77D0):(16'h77D0);
    end
else 
    begin
        audio_left_tmp <= (b_clk == 1'b0)?(~16'h0000):(16'h0000);
        audio_right_tmp <= (b_clk == 1'b0)?(~16'h0000):(16'h0000);
    end

endmodule
