
module four_bit_adder_tb();

  reg [3:0] a,b;
  reg c_in;
  wire [3:0] sum_out;
  wire carry_out;
  //assign c_in = 0;

  //Design Instantiation
  four_bit_adder DUT (.a(a),.b(b),.c_in(c_in),.sum_out(sum_out),.carry_out(carry_out));

  initial begin

  a = 4'b0000; b = 4'b0000; c_in = 1'b0;
  #10
  a = 4'b0000; b = 4'b0000; c_in = 1'b1;
  #10
  a = 4'b0000; b = 4'b0001; c_in = 1'b0;
  #10
  a = 4'b0000; b = 4'b0001; c_in = 1'b1;
  #10
  a = 4'b0001; b = 4'b0000; c_in = 1'b0;
  #10
  a = 4'b0001; b = 4'b0000; c_in = 1'b1;
  #10
  a = 4'b0001; b = 4'b0001; c_in = 1'b0;
  #10
  a = 4'b0001; b = 4'b0001; c_in = 1'b1;
  #10 $finish;
  end 

endmodule
