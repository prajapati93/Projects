
module counter_modulo12 (clk,rst,count);

parameter N = 4'd12;
parameter WIDTH = 4'd4;

//port declaration
input clk,rst;
output reg [WIDTH-1:0] count;

always @(posedge clk)
  begin
  if (!rst) begin
  count <= 4'd0;
   end
  else begin
  if (count == N-1)
   count <= 0;
   else
   count <= count + 4'd1;
   end
  end
endmodule
