
module mux_2x1_tb();

 reg a0,a1,s;
 wire f;

  //Instantiation
  mux_2x1 DUT (.a0(a0),.a1(a1),.s(s));

  initial begin
  a0 = 1'b0; a1 = 1'b0; s = 1'b0;
  #10
  a0 = 1'b0; a1 = 1'b0; s = 1'b0;
  #10
  a0 = 1'b0; a1 = 1'b0; s = 1'b0;
  #10
  a0 = 1'b0; a1 = 1'b0; s = 1'b0;
  #10 $finish;
  end

endmodule
