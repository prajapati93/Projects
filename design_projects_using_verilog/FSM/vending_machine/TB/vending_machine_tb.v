
`timescale 1ns/1ps

module vending_machine_tb();

reg clk,rstn;
reg [1:0] coin;
wire product,change;


//Instantiation
vending_machine DUT (clk,rstn,coin,product,change);

//task reset
task reset();
  begin
  @(negedge clk)
      rstn = 1'b0;
   end
endtask

task vend();
   begin
   @(negedge clk)
      rstn = 1'b1;
	end
endtask

//Clock generation
 initial begin
 clk = 1'b0;
 forever #5 clk = ~clk;
 end


//Implementation
initial begin
//$monitor ("time=",$time,"\ncoin=%0d,\nproduct=%0d,\nchange=%0d",coin,product,change);
reset;
vend;
coin = 2'b01;
$display ("time=%0t",$time,"coin=%0d,product=%0d,change=%0d",coin,product,change);
#20
coin = 2'b01;
#20;
reset;
#10
vend;   
coin = 2'b01;
#20
coin = 2'b10;
#20;
reset;
vend;   
coin = 2'b10;
#20
coin = 2'b01;
#20;
reset;
vend;   
$display ("time=%0t",$time,"coin=%0d,product=%0d,change=%0d",coin,product,change);
reset;
$finish;

end

endmodule

  



