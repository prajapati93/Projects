
module jkff_behavioural_tb();

reg j,k,rst,clk;
wire q,q_bar;

//instantiation
jkff_behavioural DUT (.j(j),.k(k),.clk(clk),.q(q),.rst(rst),.q_bar(q_bar));

//clock generator
 initial begin
   clk = 0;
 forever 
   #5 
   clk = ~clk;
 end 


//testing
initial
 begin
  //set = 1'b1;
  rst = 1'b0;
  j   = 1'b0;
  k   = 1'b0;
  clk = 1'b0;
  #5
  rst = 1'b1;
  forever
  #10 clk = ~clk;
 end
initial
 begin
 #10
 j = 1'b1;
 k = 1'b0; //set
 #10
 j = 1'b1;
 k = 1'b1; //toggle set
 #10
 j = 1'b0;
 k = 1'b0; //no change (set)
 #10
 j = 1'b0;
 k = 1'b1; //reset
 #10 $finish;
end
endmodule
