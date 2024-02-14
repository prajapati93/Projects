module mux_2 (a0,
		a1,
		s,
		z);

//define ports

input a0,a1,s;
output z;
wire s_bar,and1,and2;

//implementation

not NT  (s_bar,s);
and AN1 (and1,a0,s_bar);
and AN2 (and2,a1,s);
or  OR  (z,and1,and2);

endmodule
