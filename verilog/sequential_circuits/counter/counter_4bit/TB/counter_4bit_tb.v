
module counter_4bit_tb();

reg clk,rst;
wire [3:0] count;

//instantiation
counter_4bit DUT (.clk(clk),.rst(rst),.count(count));

//clock generator
always #5 clk = ~clk;

//testing
initial begin
  clk <= 0;
  rst <= 0;
  
 #20 rst <= 1;
 #80 rst <= 0;
 #50 rst <= 1;
 
 #10 $finish;
 end
 
endmodule
