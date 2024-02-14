
module counter_modulo12_tb();  
  
  parameter N = 4'd12;  
  parameter WIDTH = 4'd4;  
  
  reg clk,rst;    
  wire [WIDTH-1:0] count;  
  
 //istantiation 
  counter_modulo12 DUT (.clk(clk),.rst(rst),.count(count));  
 
 //clock generation 
  always #10 clk = ~clk;  
  
 //testing
  initial begin  
    {clk, rst} <= 0;  
  
    repeat(2) @ (posedge clk);  
    rst <= 1;  
  
    repeat(20) @ (posedge clk);  
    $finish;  
  end  
endmodule  
