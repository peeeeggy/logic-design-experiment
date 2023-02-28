`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 23:15:44
// Design Name: 
// Module Name: freq_div_update
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


module freq_div_update(clk,rst,clk_update);
input clk,rst;
output clk_update;

reg [25:0]tmp;
reg f_tmp;
assign clk_update = f_tmp;

always@(posedge clk or posedge rst)
if(rst )
begin
    tmp<=0;
    f_tmp<=0;
end
else if (tmp==26'd2499999) 
begin
    f_tmp <= ~f_tmp;
    tmp<=0;
end
else tmp<= tmp+26'd1;

endmodule
