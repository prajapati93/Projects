
module full_half_adder_tb();

	wire sum_out, carry_out;
	reg a, b, c_in;

	//Design instantiation
	full_adder DUT (.a(a), .b(b), .c_in(c_in), .sum_out(sum_out), .c_out(carry_out));

	initial begin
	a = 1'b0; b = 1'b0; c_in = 1'b0;
	#10
	a = 1'b0; b = 1'b0; c_in = 1'b1;
	#10
	a = 1'b0; b = 1; c_in = 0;
	#10
	a = 1'b0; b = 1; c_in = 1;
	#10
	a = 1'b1; b = 0; c_in = 0;
	#10
	a = 1'b1; b = 0; c_in = 1;
	#10
	a = 1'b1; b = 1; c_in = 0;
	#10
	a = 1'b1; b = 1; c_in = 1;
	#10 $finish;
	end


endmodule	
