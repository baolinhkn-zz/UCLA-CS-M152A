`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:36:52 03/05/2018
// Design Name:   clock_divider
// Module Name:   C:/Users/152/Desktop/final_Project/clock_divider_tb.v
// Project Name:  final_Project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock_divider
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clock_divider_tb;

	// Inputs
	reg [3:0] curr_level;
	reg rst;
	reg clk;

	// Outputs
	wire clock;

	// Instantiate the Unit Under Test (UUT)
	clock_divider uut (
		.curr_level(curr_level), 
		.rst(rst), 
		.clk(clk), 
		.clock(clock)
	);

	initial begin
		// Initialize Inputs
		curr_level = 0;
		rst = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		curr_level = 4'b0001;
		forever #1 clk = ~clk;
        
		// Add stimulus here

	end
      
endmodule

