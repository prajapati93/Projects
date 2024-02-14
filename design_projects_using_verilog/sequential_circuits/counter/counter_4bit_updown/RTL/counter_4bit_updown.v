
module counter_4bit_updown (clk,rst,set,count);

//port declaration
input clk,rst,set;
output reg [3:0] count;

//implementation
always @(posedge clk)
    begin
    if(rst == 1)
      count <= 4'b0000;
    else
    begin
    if (set == 1) // set 1 for up counting and 0 for down counting
    begin
    if (count == 15)
      count <= 4'b0000;
      count <= count + 4'b0001;
     end
    else
    begin
    if (count == 0)
      count <= 4'b1111;
    else
      count <= count - 4'b0001;
     end
    end
   end
endmodule
