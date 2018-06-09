`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:35:55 03/12/2018 
// Design Name: 
// Module Name:    LEDdisplay 
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
module LEDdisplay(
    input [3:0] curr_level,
    output [3:0] led
    );

	assign led = (curr_level == 4'b0001) ? 4'b0001 :
		(curr_level == 4'b0010) ? 4'b0010 :
		(curr_level == 4'b0011) ? 4'b0011 :
		(curr_level == 4'b0100) ? 4'b0100 :
		(curr_level == 4'b0101) ? 4'b0101 :
		(curr_level == 4'b0110) ? 4'b0110 :
		(curr_level == 4'b0111) ? 4'b0111 :
		(curr_level == 4'b1000) ? 4'b1000 :
		4'b10001 ;	

endmodule
