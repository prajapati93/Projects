
module jkff_tb();

reg j,k,rst,clk;
wire q;

//instantiation
jkff DUT (.j(j),.k(k),.clk(clk),.q(q),.rst(rst));

//clock generator
 initial begin
   clk = 0;
 forever 
   #5 
   clk = ~clk;
 end 


//testing
initial begin
rst <= 0;
j <= 0;
k <= 0;
#5
j <= 0;
k <= 1;
#10
j <= 1;
k <= 0;
#10
j <= 1;
k <= 1;
#10 $finish;
end

endmodule
