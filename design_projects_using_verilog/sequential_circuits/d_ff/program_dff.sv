program dff_tb(output d, rst, clk, input q);
initial begin
@ (posedge clk)
  rst = 1;
  d <= 0;
  #100;
  rst = 0;
  d <= 1;
  #100;
  d <= 0;
  #100
  d <= 1;
  #100 $finish;
  end
endprogram