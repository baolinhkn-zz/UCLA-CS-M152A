`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:44:21 01/29/2018 
// Design Name: 
// Module Name:    linear_to_fp 
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
module linear_to_fp( d_in, exp, sig, fifth
    );

input wire [11:0] d_in;
output wire [2:0] exp;
output wire [3:0] sig;
output wire fifth;

//obtaining number of leading zeros to determine exponent
assign exp = (d_in[11] == 1) ? 3'b111 :
	(d_in[10] == 1) ? 3'b111:
	(d_in[9] == 1) ? 3'b110:
	(d_in[8] == 1) ? 3'b101:
	(d_in[7] == 1) ? 3'b100:
	(d_in[6] == 1) ? 3'b011:
	(d_in[5] == 1) ? 3'b010:
	(d_in[4] == 1) ? 3'b001:
	3'b000;

//four bits after the last leading zero
assign sig = (d_in[11] == 1) ? d_in[11:8] :
	(d_in[10] == 1) ? d_in[10:7]:
	(d_in[9] == 1) ? d_in[9:6]:
	(d_in[8] == 1) ? d_in[8:5]:
	(d_in[7] == 1) ? d_in[7:4]:
	(d_in[6] == 1) ? d_in[6:3]:
	(d_in[5] == 1) ? d_in[5:2]:
	(d_in[4] == 1) ? d_in[4:1]:
	d_in[3:0];
	
//bit right after the significand
assign fifth = (d_in[11] == 1) ? d_in[7] :
	(d_in[10] == 1) ? d_in[6]:
	(d_in[9] == 1) ? d_in[5]:
	(d_in[8] == 1) ? d_in[4]:
	(d_in[7] == 1) ? d_in[3]:
	(d_in[6] == 1) ? d_in[2]:
	(d_in[5] == 1) ? d_in[1]:
	(d_in[4] == 1) ? d_in[0]:
	1'b0;

endmodule 