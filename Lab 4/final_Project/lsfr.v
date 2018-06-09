`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:29:34 03/05/2018 
// Design Name: 
// Module Name:    lsfr 
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
module lsfr(
    input clk,
    input rst,
    output reg [2:0] out
    );

	wire linear_feedback;
	assign linear_feedback= !(out[2] ^ out[0]);
	
	always @ (posedge clk)
	begin
		if (rst)
		begin
			out <= 3'b000;
		end
		else
		begin
			out <= {out[1],out[0],linear_feedback};
			//out <= 5;
		end
	end
endmodule
