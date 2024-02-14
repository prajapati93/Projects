
module vending_machine (clk,rstn,coin,product,change);

//Port direction
input clk, rstn;
input [1:0] coin;
output product,change;

//States
parameter IDLE = 3'b000,
          RS_1 = 3'b001,
          RS_2 = 3'b010,
       PRODUCT = 3'b011,
        CHANGE = 3'b100;

reg [2:0] pr_state,next_state;

//Present state logic
always @(posedge clk)
  if (rstn == 0)
     pr_state <= IDLE;
  else
     pr_state <= next_state;

//Next state logic
always @(pr_state,coin) begin
  case(pr_state)
     IDLE : if (coin == 2'b01)
              next_state = RS_1;
            else if (coin == 2'b01)
              next_state = RS_2;
            else
              next_state = IDLE;
     RS_1 : if (coin == 2'b01)
              next_state = RS_2;
            else if (coin == 2'b10)
              next_state = PRODUCT;
            else
              next_state = RS_1;
  
     RS_2 : if (coin == 2'b01)
              next_state = PRODUCT;
            else if (coin == 2'b10)
              next_state = CHANGE;
            else
              next_state = RS_2;

     PRODUCT : next_state = IDLE;
     CHANGE  : next_state = IDLE;
     default : next_state = IDLE;

  endcase
 end

//Output logic

assign product = (pr_state == PRODUCT) || (pr_state == CHANGE);
assign change = (pr_state == CHANGE);

endmodule
