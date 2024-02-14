
module four_bit_adder(a,b,c_in,sum_out,carry_out); 

  //Port direction
  input [3:0] a,b;
  input c_in;
  output [3:0] sum_out;
  output carry_out;
  wire c0,c1,c2;
  
  //Implementation and instantiation
  full_adder FA0 (a[0], b[0], c_in, sum_out[0], c0);
  full_adder FA1 (a[1], b[1], c0, sum_out[1], c1);
  full_adder FA2 (a[2], b[2], c1, sum_out[2], c2);
  full_adder FA3 (a[3], b[3], c2, sum_out[3], carry_out);
 
 endmodule


module full_adder(a,b,c_in,sum_out,carry_out);
  
  //Port direction
  input a,b,c_in;
  output sum_out,carry_out;

  //Implementation
  assign sum_out = (a^b^c_in);
  assign carry_out = ((a&b)|(a&c_in)|(b&c_in));

endmodule

