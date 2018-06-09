`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:26:26 01/29/2018 
// Design Name: 
// Module Name:    converter 
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
module converter( d_in, sign, mag
    );
	 
input wire [11:0] d_in;
output wire sign;
output wire [11:0] mag;
wire [11:0] temp_mag;
wire [11:0] temp_temp_mag;


assign sign = d_in[11];
assign temp_mag = (d_in[11]) ? ~(d_in) + 1'b1 : d_in;
assign temp_temp_mag = (temp_mag[11:0] == 12'b100000000000) ? ~temp_mag : temp_mag; //accounts for int min

assign mag = temp_temp_mag;

endmodule 