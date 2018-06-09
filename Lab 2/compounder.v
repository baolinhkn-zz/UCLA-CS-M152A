`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    12:22:10 01/29/2018
// Design Name:
// Module Name:    compounder
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
module compounder( D, S, E, F
    );
input wire [11:0] D;
output wire S;
output wire [2:0] E;
output wire [3:0] F;

wire [11:0] temp_d;
wire [2:0] temp_e;
wire [3:0] temp_f;
wire temp_fifth;

converter conv_t(
	.d_in(D),
	.sign(S),
	.mag(temp_d)
);

linear_to_fp ltf_t(
	.d_in(temp_d),
	.exp(temp_e),
	.sig(temp_f),
	.fifth(temp_fifth)
);

rounding round_t(
	.exp(temp_e),
	.sig(temp_f),
	.fifth(temp_fifth),
	.E(E),
	.F(F)
);

endmodule
