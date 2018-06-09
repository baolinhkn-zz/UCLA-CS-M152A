`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:48:43 02/28/2018 
// Design Name: 
// Module Name:    vga_display 
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
module vga_display(
	 input clk,
    input dclk,
	 input levelclk,
	 input move_clk,
	 input rst,
    input clr,
	 input wire [9:0] jstk_val,
    output hsync,
    output vsync,
    output reg [2:0] red,
    output reg [2:0] green,
    output reg [1:0] blue,
	 output startOverFlag
    );

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 151; //; //31 		// end of vertical back porch
parameter vfp = 391; //511; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;


// Horizontal & vertical counters --
// this is how we keep track of where we are on the screen.
// ------------------------
// Sequential "always block", which is a block that is
// only triggered on signal transitions or "edges".
// posedge = rising edge  &  negedge = falling edge
// Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge dclk or posedge clr)
begin
	// reset condition
	if (clr == 1)
	begin
		hc <= 0;
		vc <= 0;
	end
	else
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;


//array 12x32
reg [31:0] board[11:0]; //array of 32 bit registers
reg jstk_flag = 0;

integer k;
integer j;
integer i;
integer x;

wire [32:0] h;
wire [32:0] v;

assign h = (hc-hbp)/20;
assign v = (vc-vbp)/20;

reg player_x = 1;

reg[3:0] player_y;

reg start_over = 0;

reg [2:0] flag = 3'b000;



wire [2:0] r;

lsfr lsfr_mod(
	.clk(levelclk),
	.rst(rst),
	.out(r)
);

//make this faster
always @(posedge move_clk or posedge rst)
begin
	if (rst == 1)
	begin
		player_y <= 4'b0110;
	end
	else
	begin
		if (jstk_val >= 700 && jstk_flag != 1 && player_y > 0)
		begin
			player_y <= player_y - 4'b0001;
			jstk_flag <= 1;
		end
		else if (jstk_val <= 300 && jstk_flag != 1 && player_y < 11)
		begin
			player_y <= player_y + 4'b0001;
			jstk_flag <= 1;
		end
		else
		begin
			player_y <= player_y;
			jstk_flag <= 1'b0;
		end
	end
end


//checks if player hits wall
always @*
begin
	for (j=0; j < 12; j=j+1)
	begin
		if (rst == 1)
		begin
			/*if (start_over == 0)
			begin
				start_over = 1;
			end
			else
			begin
			 start_over = 0;
			end*/
			start_over = ~start_over;
		end
		if (board[player_y][1] == 0)
		//if (!(player_y >= r && player_y <= r+2) && (board[0][1] == 0 || board[11][1] == 0))
		begin
			start_over = 1;
		end
	end
end


always @ (posedge levelclk)
begin
	for (k = 0; k < 12; k=k+1)
	begin
		if (start_over == 1 || rst == 1)
		begin
			board[k] <= 32'b1111_1111_1111_1111_1111_1111_1111_1111;
		end
		else
		begin
			board[k] <= board[k] >> 1;
			if (flag == 3'b100)
			begin
				if (k == r+1 || k == r || k == r+2)
				begin
					board[k][31] <= 1;
				end
				else
				begin
					board[k][31] <= 0;
				end
				flag <= 3'b000;
			end
			else
			begin
				board[k][31] <= 1;
			end
		end
	end
	flag <= flag + 1;
end

// display 100% saturation colorbars
// ------------------------
// Combinational "always block", which is a block that is
// triggered when anything in the "sensitivity list" changes.
// The asterisk implies that everything that is capable of triggering the block
// is automatically included in the sensitivty list.  In this case, it would be
// equivalent to the following: always @(hc, vc)
// Assignment statements can only be used on type "reg" and should be of the "blocking" type: =

always @(posedge dclk)
begin
	// first check if we're within vertical active video range
	if (vc >= vbp && vc < vfp)
	begin
		if (hc >= hbp && hc < (hbp+640))
		begin
			if (board[v][h] == 1 && !(v == player_y && h == player_x))
			begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b11;
			end
			else if (v == player_y && h == player_x)
			begin
				red = 3'b111;
				green = 0;
				blue = 0;							
			end
			else
			begin
				red = 0;
				green = 0;
				blue = 0;
			end
		end
		//outside active horizontal range so display black
		else
		begin
			red = 0;
			green = 0;
			blue = 0;
		end
	// we're outside active vertical range so display black
	end
	else
	begin
		red = 0;
		green = 0;
		blue = 0;
	end
end

assign startOverFlag = start_over;

endmodule