
module counter_4bit_updown_tb();

reg clk,rst,set;
wire [3:0] count;

//instantiation
counter_4bit_updown DUT (.clk(clk),.rst(rst),.set(set),.count(count));

//clock generator
always #5 clk = ~clk;

//testing
initial begin
clk = 0;
rst = 0;
set = 0;

 rst = 1;
 set = 0;
 #20;
 rst = 0;
 #40;
 set = 1;
 end
 
endmodule
