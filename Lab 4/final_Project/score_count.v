`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:23:30 03/12/2018 
// Design Name: 
// Module Name:    score_count 
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
module score_count(
    output [3:0] curr_level,
    input clk,
    input rst,
    output [13:0] score,
	 input startOverFlag
    );
	
	integer div_factor = 50000000;
	reg [31:0] counter;
	reg one_hz_clk;
	
	reg[13:0] score_reg;
	reg[3:0] curr_level_reg;

	always @ (posedge clk or posedge rst)
	begin
		if (rst == 1'b1)
		begin
			counter <= 32'b0;
			one_hz_clk <= 1'b0;
		end
		else if (counter == div_factor -1)
		begin
			counter <= 32'b0;
			one_hz_clk <= ~one_hz_clk;
		end
		else
		begin
			counter <= counter + 32'b1;
			one_hz_clk <= one_hz_clk;
		end
	end
		
	always @ (posedge one_hz_clk or posedge rst)
	begin
		if (rst == 1'b1)
		begin
			curr_level_reg <= 4'b0000;
			score_reg <= 0;
		end
		else
		begin
			if (score_reg < 9999)
			beginw
				if (score_reg % 1000 == 0 /*&& startOverFlag != 1*/)
				begin
					curr_level_reg <= curr_level_reg + 1;
				end
				else
				begin
					curr_level_reg <= curr_level_reg;
				end
				if (startOverFlag != 1)
				begin
					score_reg <= score_reg + 1;
				end
				else
				begin
					score_reg <= score_reg;
				end
			end
			else
			begin
				score_reg <= 0;
			end
		end
	end
	
	assign score = score_reg;
	assign curr_level = curr_level_reg;

endmodule
