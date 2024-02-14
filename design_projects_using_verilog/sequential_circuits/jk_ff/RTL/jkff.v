
module jkff (j,k,rst,clk,q);

//Ports description
input j,k,rst,clk;
output reg q;

//parameter
parameter no_change = 2'b00;
parameter	  reset = 2'b01;
parameter	  set   = 2'b10;
parameter     toggle = 2'b11;

//implementation
always @(posedge clk)
if (rst==1)
q <= 1'b0;
else begin
case ({j,k})
no_change : q <= q;
reset : q <= 1'b0;
set : q <= 1'b1;
toggle : q <= ~q;
endcase
end

endmodule
