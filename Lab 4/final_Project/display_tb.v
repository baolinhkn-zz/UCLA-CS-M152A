`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:42:41 03/07/2018
// Design Name:   vga_display
// Module Name:   C:/Users/152/Desktop/final_Project/display_tb.v
// Project Name:  final_Project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_display
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module display_tb;

	// Inputs
	reg clk;
	reg dclk;
	reg levelclk;
	reg clr;
	reg [9:0] jstk_val;

	// Outputs
	wire hsync;
	wire vsync;
	wire [2:0] red;
	wire [2:0] green;
	wire [1:0] blue;

	// Instantiate the Unit Under Test (UUT)
	vga_display uut (
		.clk(clk), 
		.dclk(dclk), 
		.levelclk(levelclk), 
		.clr(clr), 
		.jstk_val(jstk_val), 
		.hsync(hsync), 
		.vsync(vsync), 
		.red(red), 
		.green(green), 
		.blue(blue)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		dclk = 0;
		levelclk = 0;
		clr = 0;
		jstk_val = 800;

		// Wait 100 ns for global reset to finish
		#100;
		forever #1 levelclk=~levelclk;
        
		// Add stimulus here

	end
      
endmodule

