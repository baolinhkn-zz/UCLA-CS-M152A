`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:18:47 02/28/2018 
// Design Name: 
// Module Name:    clock_divider 
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
module clock_divider(
    input [3:0] curr_level,
	 input rst,
	 input clk,
    output clock,
	 output move
    );
	 
	reg[31:0] counter = 0;
	reg [31:0] cnt = 0;
	reg game_clk;
	reg tempclk;
	
	wire [32:0] div_factor;
	
	
	assign div_factor = (curr_level == 4'b0001) ? 38000000 :
		(curr_level == 4'b0010) ? 36000000 :
		(curr_level == 4'b0011) ? 34000000 :
		(curr_level == 4'b0100) ? 32000000 :
		(curr_level == 4'b0101) ? 30000000 :
		(curr_level == 4'b0110) ? 28000000 :
		(curr_level == 4'b0111) ? 26000000 :
		(curr_level == 4'b1000) ? 24000000 :
		22000000 ;
		
	always @ (posedge clk or posedge rst)
	begin
		if (rst == 1'b1)
		begin
			counter <= 32'b0;
			game_clk <= 1'b0;
		end
		else if (counter == div_factor -1)
		begin
			counter <= 32'b0;
			game_clk <= ~game_clk;
		end
		else
		begin
			counter <= counter + 32'b1;
			game_clk <= game_clk;
		end
	end
	
	integer x = 8000000;
	
	always @ (posedge clk or posedge rst)
	begin
		if (rst == 1'b1)
		begin
			cnt <= 32'b0;
			tempclk <= 1'b0;
		end
		else if (cnt == x -1)
		begin
			cnt <= 32'b0;
			tempclk <= ~tempclk;
		end
		else
		begin
			cnt <= cnt + 32'b1;
			tempclk <= tempclk;
		end
	end
	
	assign move = tempclk;
	assign clock = game_clk;


endmodule