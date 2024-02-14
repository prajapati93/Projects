
module dff_tb();
reg d,rst,clk;
wire q;

//instantiation
dff DUT (d,rst,clk,q);

//clock generator
 initial begin
   clk = 0;
 forever #10 
   clk = ~clk;
 end 

//Testing
 initial begin
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
endmodule 
