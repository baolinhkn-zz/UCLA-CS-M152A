`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:37:01 01/29/2018
// Design Name:   compounder
// Module Name:   C:/Users/152/Desktop/lab2/compounder_tb.v
// Project Name:  lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: compounder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module compounder_tb;

	// Inputs
	reg [11:0] D;

	// Outputs
	wire S;
	wire [2:0] E;
	wire [3:0] F;

	// Instantiate the Unit Under Test (UUT)
	compounder uut (
		.D(D), 
		.S(S), 
		.E(E), 
		.F(F)
	);

	initial begin
		// Initialize Inputs
		D = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		D = 69;
		#100;
		D = 100;
		#100;
		D = 2047;
		#100;
		D = -69;
		#100;
		D = -100;
		#100;
		D = -2048;
		#100;
		D = 0;
		#100;
		D = 1921;
		#100;
		D = -1921;
		#100;
		D = 1;
		#100;
		D = -1;
		#100;
		D = 8;
		#100;
		D = -8;
		#100;
		D = 24;
		#100;
		D = -24;
		#100;
		D = 16;
		#100;
		D = -16;
		#100;
		D = 31;
		#100;
		D = -31;
		#100;
		D = 200;
		#100;
		D = -200;
		#100;
		
	end
      
endmodule

