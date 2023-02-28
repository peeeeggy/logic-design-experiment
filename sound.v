`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/11 01:47:26
// Design Name: 
// Module Name: sound
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

`define do 22'd191571
`define re 22'd170648
`define mi 22'd151515
`define fa 22'd143266
`define so 22'd127551
`define la 22'd113636
`define si 22'd101215
`define high_do 22'd95420

module sound(clk,rst,start,gameover,pitch,music);
input clk,rst,start,gameover;
output reg [21:0] pitch;
output reg music;

reg [21:0] note1, note2, note3, note4;
reg [3:0] cnt_1, cnt_2;
reg [21:0] pitch_tmp1, pitch_tmp2;
reg [2:0]cnt;

always@(posedge clk or posedge rst)
if(rst || (~start)) music <= 0;
else if(gameover && (cnt != 3'b111)) music <= 1;
else if(cnt == 3'b111) music <= 0;

always@(posedge clk or posedge rst)
if(rst || (~start)) cnt <=3'b000;
else if(music && (cnt < 3'b111)) cnt <= cnt +3'b1;

always@(cnt)
case(cnt)
    3'b000: pitch = `si;
    3'b001: pitch = `fa;
    3'b010: pitch = `fa;
    3'b011: pitch = `fa;
    3'b100: pitch = `mi;
    3'b101: pitch = `re;
    3'b110: pitch = `do;
    3'b111: pitch = `do;
endcase
/*
always@(posedge clk or posedge rst)
if(rst || (~start)) music <= 0;
else if(gameover && ((cnt_1 != 3'b111) ^ (cnt_2 != 3'b111))) music <= 1;
else if((cnt_1 == 3'b111) | (cnt_2 == 3'b111)) music <= 0;

always @(posedge clk or posedge rst)
if(rst || (~start)) 
    begin
        cnt_1 <= 3'b000;
        cnt_2 <= 3'b000;
    end
else if(music && start && (cnt_1 < 3'b111))
    begin
        cnt_1 <= cnt_1 +3'b1;
        cnt_2 <= 3'b0;
    end
else if(music && (cnt_2 < 3'b111))
    begin
        cnt_1 <= 3'b000;
        cnt_2 <= cnt_2 + 3'b1;
    end
 

always @(cnt_1)
case (cnt_1)
    3'b000: pitch_tmp1 = `mi;
    3'b001: pitch_tmp1 = `mi;
    3'b010: pitch_tmp1 = `mi;
    3'b011: pitch_tmp1 = `mi;
    3'b100: pitch_tmp1 = `do;
    3'b101: pitch_tmp1 = `mi;
    3'b110: pitch_tmp1 = `so;
    3'b111: pitch_tmp1 = `so;
endcase

always @(cnt_2)
case (cnt_2)
    3'b000: pitch_tmp2 = `si;
    3'b001: pitch_tmp2 = `fa;
    3'b010: pitch_tmp2 = `fa;
    3'b011: pitch_tmp2 = `fa;
    3'b100: pitch_tmp2 = `mi;
    3'b101: pitch_tmp2 = `re;
    3'b110: pitch_tmp2 = `do;
    3'b111: pitch_tmp2 = `do;
endcase

always @(posedge clk or posedge rst)
if (start)
    pitch = pitch_tmp1;
else if (gameover)
    pitch = pitch_tmp2;
    
*/
endmodule



