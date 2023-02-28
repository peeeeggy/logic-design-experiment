`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/06 11:27:42
// Design Name: 
// Module Name: display
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


`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001

module display(dig,
               ssd          
);

input [3:0] dig;
output [7:0] ssd;

reg [7:0] ssd;

always @ (*) begin
    case (dig)
        4'd0: ssd = `SS_0;
        4'd1: ssd = `SS_1;
        4'd2: ssd = `SS_2;
        4'd3: ssd = `SS_3;
        4'd4: ssd = `SS_4;
        4'd5: ssd = `SS_5;
        4'd6: ssd = `SS_6;
        4'd7: ssd = `SS_7;
        4'd8: ssd = `SS_8;
        4'd9: ssd = `SS_9;
        default: ssd = 8'b01110001;
    endcase
end

endmodule        
