
module mux_two (input a0, input a1, input s, output f);

wire x,y,s_bar;

// implementation
assign s_bar = !s;
assign x = a0 & s_bar;
assign y = a1 & s;
assign f = x | y;

endmodule
