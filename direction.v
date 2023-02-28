`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/11 01:28:42
// Design Name: 
// Module Name: direction
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


module direction(clk,rst,start,last_change,direc,key_down,key_valid);
input clk,rst,start;
input [511:0] key_down;
input [8:0] last_change;
input key_valid;
output reg [3:0] direc;

reg key_in;
reg [8:0] last_change_tmp;

always@ (posedge clk or posedge rst) 
    if (rst)
        begin
            last_change_tmp <= 9'b0_0000_0000;
            key_in <= 1'b0;
        end
    else if (key_valid && key_down[last_change])
        begin
            last_change_tmp <= last_change;
            key_in <= 1'b1;
        end
    else
        begin
            last_change_tmp <= last_change_tmp;
            key_in <= 1'b0;
        end

always @(posedge clk or posedge rst)
if (rst)
        direc <= 4'd0;
else if (last_change_tmp && start)
case (last_change_tmp)
    8'b0001_1101: direc = 4'b1000;
    8'b0001_1011: direc = 4'b0100;
    8'b0001_1100: direc = 4'b0010;
    8'b0010_0011: direc = 4'b0001;
    default direc = 4'b1000;
endcase   
endmodule
