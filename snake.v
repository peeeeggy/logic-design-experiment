`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 23:45:33
// Design Name: 
// Module Name: snake
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

module snake(vgaRed,vgaGreen,vgaBlue,hsync,vsync,in,clk,rst,PS2_DATA,PS2_CLK,display_c,ssd,level1,level2,level3,led,start,audio_mclk,audio_lrck,audio_sck,audio_sdin);
input clk,rst;
input level1;
input level2;
input level3;
input start;
input in;

inout PS2_DATA,PS2_CLK;
output reg [3:0]vgaRed,vgaGreen,vgaBlue;
output hsync,vsync;
output [3:0]display_c;
output [7:0]ssd;
output [3:0]led;
output audio_sdin;
output audio_mclk,audio_lrck,audio_sck;

wire clk_10,clk_vga,clk_update,valid;
wire [9:0] h_cnt;
wire [9:0] v_cnt;
wire [3:0] dir;
wire [9:0]rand_x,rand_y;

wire [9:0]speed;
wire [511:0]key_down;
wire [8:0]last_change;
wire key_valid;
wire [1:0]ssd_ctl;
wire [7:0]disp0,disp1,disp2,disp3;
wire [15:0]audio_right,audio_left;
wire [21:0]pitch;
wire music;

wire [16:0] pixel_addr;
wire [11:0] pixel;
wire [11:0] data;

wire lethal,nonlethal;

integer applecnt,cnt1,cnt2;
reg apple;
reg border;
reg found;
reg good_collision,bad_collision,gameover;
reg head;
reg body;
reg [3:0]dig0,dig1,dig2,dig3;
reg [9:0]apple_x,apple_y;
reg inx,iny;
reg [9:0]snake_x[0:127];
reg [9:0]snake_y[0:127];
reg [9:0]head_x,head_y;
reg [9:0]score;
reg [9:0]score_tmp;
reg [9:0]highest_score;
reg [6:0]size;
reg [6:0]cnt3;
wire R,G,B;


assign lethal = (border || body);
assign nonlethal = apple;
assign pixel_addr = ((h_cnt>>1)+320*(v_cnt>>1))% 76800;


freq_div(.clk(clk), .rst(rst), .clk_1(clk_1), .clk_10(clk_10), .clk_25M(clk_vga));
freq_control (.clk(clk), .clk_ctl(clk_ctl));
freq_div_update FD_U(.clk(clk), .rst(rst), .clk_update(clk_update));
speed SPEE(.clk(clk), .clk_10(clk_10), .rst(rst), .level1(level1), .level2(level2), .level3(level3), .speed(speed), .led(led));
display U_SSD3(.ssd(disp3), .dig(dig3));
display U_SSD2(.ssd(disp2), .dig(dig2));
display U_SSD1(.ssd(disp1), .dig(dig1));
display U_SSD0(.ssd(disp0), .dig(dig0));
scan_control U_CTL(.display_c(display_c), .display(ssd), .ssd_ctl(ssd_ctl), .display0(disp0), .display1(disp1), .display2(disp2), .display3(disp3));
vga VGA(
    .pclk(clk_vga),
    .reset(rst),
    .hsync(hsync),
    .vsync(vsync),
    .valid(valid),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt)
);
/*blk_mem_gen_0 blk_mem_gen_0_inst
(
    .clka(clk_vga),
    .wea(0),
    .addra(pixel_addr),
    .dina(data[11:0]),
    .douta(pixel)
); */
KeyboardDecoder U_KeyboardDecoder(
    .clk(clk),
    .rst(rst),
    .PS2_DATA(PS2_DATA), 
    .PS2_CLK(PS2_CLK), 
    .key_down(key_down),
    .last_change(last_change),
    .key_valid(key_valid)
);
direction DIR(
    .clk(clk),
    .rst(rst),
    .key_down(key_down),
    .last_change(last_change),
    .key_valid(key_valid),
    .direc(dir),
    .start(start)
);
random_point RAND(
    .clk_vga(clk_vga),
    .rst(rst),
    .rand_x(rand_x),
    .rand_y(rand_y)
);
note_generator Ung(
    .clk(clk),
    .rst(rst),
    .music(music),
    .audio_left(audio_left),
    .audio_right(audio_right),
    .start(start),
    .pitch(pitch)
);
speaker_control Us(
    .clk(clk),
    .rst(rst),
    .audio_in_left(audio_left),
    .audio_in_right(audio_right),
    .audio_mclk(audio_mclk),
    .audio_lrck(audio_lrck),
    .audio_sck(audio_sck),
    .audio_sdin(audio_sdin)
);
sound SOUND(
    .clk(clk_10),
    .rst(rst),
    .start(start),
    .gameover(gameover),
    .music(music),
    .pitch(pitch)
);

//define apple
always@(posedge clk_vga)
begin
    inx <=((h_cnt>apple_x) && (h_cnt<(apple_x+10'd10)));
    iny <=((v_cnt>apple_y) && (v_cnt<(apple_y+10'd10)));
    apple <= inx&&iny;
end
//define border
always@(posedge clk_vga)
begin
    border <= (((h_cnt>=0)&&(h_cnt<10'd11)||(h_cnt>=10'd630)&&(h_cnt<10'd641))||((v_cnt>=0)&&(v_cnt<10'd11)||(v_cnt>=10'd470)&&(v_cnt<10'd481)));
end
//define head
always@(posedge clk_vga)
begin
    head <= (h_cnt>snake_x[0] && h_cnt<(snake_x[0]+10'd10)) && (v_cnt>snake_y[0] && v_cnt<(snake_y[0]+10'd10));
end
//change the pos. of apple
always@(posedge clk_vga)
begin
applecnt = applecnt+1;
    if(applecnt == 1) begin
        apple_x <= 10'd300;
        apple_y <= 10'd100;
    end
    else begin
        if(good_collision)begin
            apple_x <= rand_x;
            apple_y <= rand_y;
        end
        else if(~start) begin
            apple_x <= 10'd300;
            apple_y <= 10'd100;
        end
    end
end
//move
always@(posedge clk_update)
begin
    if(start) begin
        for(cnt1 = 127;cnt1>0;cnt1 = cnt1-1)
        begin
            if(cnt1<= size-1) begin
                snake_x[cnt1] <= snake_x[cnt1-1];
                snake_y[cnt1] <= snake_y[cnt1-1];
            end
        end
        case(dir)
            4'b0001:snake_x[0] <= snake_x[0] - speed;
            4'b0010:snake_x[0] <= snake_x[0] + speed;
            4'b0100:snake_y[0] <= snake_y[0] + speed;
            4'b1000:snake_y[0] <= snake_y[0] - speed;
        endcase
    end
    else if(~start) begin
        for(cnt2 = 0;cnt2<=127;cnt2 = cnt2+1)
        begin
        snake_x[cnt2] <= 10'd100;
        snake_y[cnt2] <= 10'd100;
        end
    end
end
//body

always@(posedge clk_vga)
begin
	found = 0;
	for(cnt3 = 1; cnt3 < size; cnt3 = cnt3 + 1)
	begin
		if(~found)
		begin				
			body = (h_cnt>snake_x[cnt3] && h_cnt<(snake_x[cnt3]+10'd10)) && (v_cnt>snake_y[cnt3] && v_cnt<(snake_y[cnt3]+10'd10));
			found = body;
		end
    end
end
//score up
always@(posedge clk_vga)
if(nonlethal && head)
begin
    size <= size + 1;
    good_collision <= 1;
end
else if(~start) size <= 7'd1;
else good_collision <= 0;

always@(posedge clk_vga)
begin
    if(good_collision) score_tmp <= score_tmp + 5;
    else if(~start) score <= 0;
    else score <= score_tmp;
    if(score_tmp > highest_score)
        highest_score <= score_tmp;
end
always@(posedge clk_vga)
if(in) begin
    dig3 <= highest_score/1000;
    dig2 <= (highest_score%1000)/100;
    dig1 = (highest_score%100)/10;
    dig0 = highest_score%10;
end
else
begin
    dig3 <= score/1000;
    dig2 <= (score%1000)/100;
    dig1 = (score%100)/10;
    dig0 = score%10;
end
//gameover
always@(posedge clk_vga)
if(lethal && head) bad_collision <= 1;
else bad_collision <= 0;
always@(posedge clk_vga)
if(bad_collision) gameover <= 1;
else if(~start) gameover <= 0;
//draw color on vga
assign   R = (valid&&apple);
assign   G = (valid&&(head || body));
assign   B = (valid&&border);
always@(posedge clk_vga)
if(gameover)begin
    {vgaRed,vgaGreen,vgaBlue} <= (valid==1'b1)?pixel:12'h0;
end
else begin
    vgaRed <= {4{R}};
    vgaGreen <= {4{G}};
    vgaBlue <= {4{B}};
end

endmodule
