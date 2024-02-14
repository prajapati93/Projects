
module jkff_behavioural (j,k,set,rst,clk,q,q_bar);

//Ports description
input wire j,k,set,rst,clk;
output reg q,q_bar;

//implementation
initial q = 1'b0;
  always @(posedge clk or negedge set or negedge rst) 
  begin
    if (~rst)
     begin
      q <= 1'b0;
      q_bar <= 1'b1;
     end 
     else if (~set)
      begin
      q <= 1'b1;
      q_bar <= 1'b0;
      end
     else if (j==1'b0 && k==1'b0)
      begin
      q <= q;
      q_bar <= q_bar;
      end
     else if (j==1'b0 && k==1'b1)
      begin
      q <= 1'b0;
      q_bar <= 1'b1;
      end
     else if (j==1'b1 && k==1'b0)
      begin
      q <= 1'b1;
      q_bar <= 1'b0;
      end
     else if (j==1'b1 && k==1'b1)
      begin
      q <= q_bar;
      q_bar <= q;
      end
     end
endmodule
