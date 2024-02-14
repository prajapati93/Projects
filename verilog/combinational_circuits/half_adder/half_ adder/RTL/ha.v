
module half_adder (a,
		   b,
		   sum,
		   carry);
	
	//Port direction
	input a,b;
	output sum,carry;
	
	//implementation
	xor SM (sum,a,b);
	and CR (carry,a,b);
	
endmodule
	
