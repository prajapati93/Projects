
module DUT (d,rst,clk,q);

//port declaration
input d,rst,clk;
output reg q;

//implementation
always @(posedge clk)
  begin
  if(rst==1'b1)
    q <= 1'b0;
  else
    q <= d;
  end
endmodule
