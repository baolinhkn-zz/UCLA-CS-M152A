`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:47:19 02/28/2018 
// Design Name: 
// Module Name:    game_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module game_top(
    input clk,
    input clr,
	 input rst,
	 input MISO,					// Master In Slave Out, Pin 3, Port JA
	 input [2:0] SW,			// Switches 2, 1, and 0
	 output SS,					// Slave Select, Pin 1, Port JA
	 output MOSI,				// Master Out Slave In, Pin 2, Port JA
	 output SCLK,				// Serial Clock, Pin 4, Port JA
	 output [3:0] led,			// LEDs 2, 1, and 0
	 output [6:0] seg,
    output [3:0] an,
    output dp,
    output [2:0] red,
    output [2:0] green,
    output [1:0] blue,
    output hsync,
    output vsync
    );

wire dclk;
wire startOverFlag;
wire level_clk;
wire move_clk;

wire clr;

wire [3:0] c_level;

wire [9:0] position_data;

wire [13:0] curr_score;

score_count score_count_mod (
    .curr_level(c_level),
    .clk(clk),
    .rst(rst),
    .score(curr_score),
	 .startOverFlag(startOverFlag)
);

LEDdisplay LEDdisplay_mod (
	.curr_level(c_level),
	.led(led)
);

clock_divider clock_divider_mod (
    .curr_level(c_level),
	 .rst(rst),
	 .clk(clk),
    .clock(level_clk),
	 .move(move_clk)
	);
	
ssdCtrl ssdCtrl_mod (
		.CLK(clk),
		.RST(rst),
		.DIN(curr_score),
		.AN(an),
		.SEG(seg)
	);

display_clock_div display_clock_div_mod (
	.clk(clk),
	.clr(clr),
	.dclk(dclk)
	);
	
PmodJSTK_Demo jstk_mod(
    .CLK(clk),
    .RST(rst),
    .MISO(MISO),
	 .SW(SW),
    .SS(SS),
    .MOSI(MOSI),
    .SCLK(SCLK),
   // .LED(led),
	 .posData(position_data)
    );

vga_display vga_display_mod (
	.clk(clk),
	.dclk(dclk),
	.levelclk(level_clk),
	.move_clk(move_clk),
	.rst(rst),
	.clr(clr),
	.jstk_val(position_data),
	.hsync(hsync),
	.vsync(vsync),
	.red(red),
	.green(green),
	.blue(blue),
	.startOverFlag(startOverFlag)
	);



endmodule
