`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:10:18 01/29/2018 
// Design Name: 
// Module Name:    rouding 
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
module rouding(
    input [2:0] exp,
    input [3:0] sig,
    input fifth,
    output [2:0] E,
    output [3:0] F
    );
	 
wire [2:0] temp_exp;// = exp;
wire [4:0] temp_sig;// = sig;
wire [4:0] temp_temp_sig;

assign temp_exp = (fifth == 1 && sig == 4'b1111) ? ((exp == 3'b111) ? exp : exp + 1) : exp;
assign temp_sig = (fifth == 1) ?  sig + 1 : sig;
assign temp_temp_sig = (fifth == 1) ? ((temp_sig == 5'b10000) ? temp_sig >> 1 : temp_sig) : temp_sig;

assign E = temp_exp;
assign F = (sig == 4'b1111 && exp == 3'b111 && fifth == 1'b1) ? 4'b1111 : temp_temp_sig[3:0];
endmodule 