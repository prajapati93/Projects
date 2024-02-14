
module full_adder (a,
		   b,
		   c_in,
		   sum_out,
		   carry_out);

	//Port direction
	input a, b, c_in;
	output sum_out, carry_out;
	wire s1, c1, c2;

	//Implementation
	half_adder HA1 (.sum(s1), .carry(c1), .a(a), .b(b));
	half_adder HA2 (.sum(sum_out), .carry(c2), .a(s1), .b(c_in));
	or OR1 (carry_out, c2, c1);

endmodule	
