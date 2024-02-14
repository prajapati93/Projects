
module traffic_controller_tb();

//Variable declaration
wire [1:0] highway, country;
reg ctrl;
reg clk,clear;

//Instantiation
traffic_controller DUT (highway,country,ctrl,clk,clear);

//Clock generator
initial begin
  clk = 1'b0;
  forever #5 clk = ~clk;
  end

//Setup control signal
initial begin
  clear = 1'b1;
  repeat (5) @(negedge clk);
  clear = 1'b0;
  end
  
//Stimulus
initial begin
 $monitor($time, "highway = %b country = %b ctrl = %b", highway,country,ctrl);
 
 ctrl = 1'b0;
 #200 ctrl = 1'b1;
 #100 ctrl = 1'b0;
 #200 ctrl = 1'b1;
 #100 ctrl = 1'b0;
 #200 ctrl = 1'b1;
 #100 ctrl = 1'b0;
 #100 $stop;
 
 end
 endmodule
