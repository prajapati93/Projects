
module dff_behavioral (d,rst,clk,q,q_bar);

input wire d,rst,clk;
output reg q,q_bar;

assign q_bar = ~q;

always @(posedge clk)
  begin
  if (rst == 1'b0)
    q = 1'b0;
    else q = d;
    end
    
end module
