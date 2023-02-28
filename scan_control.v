`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/26 01:05:12
// Design Name: 
// Module Name: ssd_ctl
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


module scan_control (ssd_ctl,
                     display,
                     display_c,
                     display0,
                     display1,
                     display2,
                     display3
);
output [7:0] display;
output[3:0]display_c;
input [1:0]ssd_ctl;
input[7:0]display0,display1,display2,display3;

reg[7:0]display;
reg[3:0]display_c;

always @(ssd_ctl)
// display value selection
case(ssd_ctl)
2'b00: display = display0;
2'b01: display = display1;
2'b10: display = display2;
2'b11: display = display3;
default : display = 8'b11111111;
endcase
// 7-segment control
always @(ssd_ctl)
case(ssd_ctl)
2'b00: display_c = 4'b1110;
2'b01: display_c = 4'b1101;
2'b10: display_c = 4'b1011;
2'b11: display_c = 4'b0111;
default : display_c = 4'b1111;
endcase

endmodule