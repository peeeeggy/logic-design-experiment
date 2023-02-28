`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/26 21:07:34
// Design Name: 
// Module Name: speaker_control
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


module speaker_control(clk,rst,audio_mclk,audio_lrck,audio_sck,audio_in_left,audio_in_right,audio_sdin);
input clk,rst;
input [15:0]audio_in_left,audio_in_right;
output audio_sdin;
output audio_mclk,audio_lrck,audio_sck;
reg [9:0]tmp;
reg [31:0]in_tmp;
reg[4:0]count;
assign audio_mclk = tmp[1];
assign audio_lrck = tmp[8];
assign audio_sck = tmp[3];
assign audio_sdin = in_tmp[31];

always@(posedge clk or posedge rst)
if(rst)  tmp<=0;
else if(tmp==10'd1023) tmp<=0;
else tmp<=tmp+10'd1;

always@(posedge tmp[3] or posedge rst)
if(rst) 
begin
    count <= 0;
end
else if(count==0)
begin
    in_tmp <= {audio_in_left,audio_in_right};
    count<=count+5'd1;
end 
else
begin
    in_tmp <= {in_tmp[30:0],in_tmp[31]};
    count<=count+5'd1;
end 

endmodule
