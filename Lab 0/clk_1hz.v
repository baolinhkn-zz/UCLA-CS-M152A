module clk_1hz(clk, cnt, led, a);
input clk, cnt;
output reg led, a;

always @ (posedge clk)
begin
	led <= ~a;
	a = ~a;
end
endmodule
		