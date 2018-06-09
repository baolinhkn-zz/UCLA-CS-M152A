`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:52 02/07/2018 
// Design Name: 
// Module Name:    counter 
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
module counter(
	input wire clk,
	input wire rst,
	output wire [3:0] sec_one,
	output wire [3:0] sec_ten,
	output wire [3:0] min_one,
	output wire [3:0] min_ten
    );
	 
	reg [7:0] clk_1hz;
	integer div = 50000000; //50 mil
	 
	reg [26:0] counter;
	 
	always @(posedge clk or posedge rst) 
	begin
		if (rst == 1'b1)
			counter <= 27'b0;
		else if (counter == div -1)
			counter <= 27'b0;
		else
			counter <= counter + 27'b1;
	end
	
	always @(posedge clk or posedge rst)
	begin
		if (rst == 1'b1)
			clk_1hz <= 0;
		else if (counter == div - 1)
			clk_1hz <= clk_1hz + 27'b1;
		else
			clk_1hz <= clk_1hz;
	end
	
	
	//seconds
	always @(posedge clk_1hz or rst)
	begin
		//if secone = 9 and secten = 5
		if (sec_one == 4'b1001)
		begin
			sec_one <= 4'b0000;
			if (sec_ten == 4'b0101)
			begin
				sec_ten <= 4'b0000;
				min_one <= min_one + 4'b0001;
                if ()
                    if()
                        if()
			end
		end
		//else
			//increment
	end
	//minutes
endmodule


