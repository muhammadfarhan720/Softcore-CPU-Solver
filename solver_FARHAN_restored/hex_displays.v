module hex_displays(
	input  [23:0] value,
	output  [6:0] hex5, hex4, hex3, hex2, hex1, hex0
);

	hex_display h5(value[23:20], hex5),
	            h4(value[19:16], hex4),
					h3(value[15:12], hex3),
					h2(value[11: 8], hex2),
					h1(value[ 7: 4], hex1),
					h0(value[ 3: 0], hex0);

endmodule

module hex_display(
   input      [3:0] digit,
	output reg [7:0] hex
);
	always@(digit) begin
	   case(digit)
			4'h0:    hex = 7'h40;
			4'h1:    hex = 7'h79;
			4'h2:    hex = 7'h24;
			4'h3:    hex = 7'h30;
			4'h4:    hex = 7'h19;
			4'h5:    hex = 7'h12;
			4'h6:    hex = 7'h02;
			4'h7:    hex = 7'h78;
			4'h8:    hex = 7'h00;
			4'h9:    hex = 7'h10;
			4'ha:    hex = 7'h08;
			4'hb:    hex = 7'h03;
			4'hc:    hex = 7'h46;
			4'hd:    hex = 7'h21;
			4'he:    hex = 7'h06;
			4'hf:    hex = 7'h0e;
			default: hex = 7'h7f;
		endcase
	end
	
endmodule
