//Sequence detector using FSM (MOORE) - 1011

module sequence_detector (sequence,clk,rstn,out);

//Port direction
input clk,rstn,sequence;
output reg out;

//States declaration
parameter S0 = 3'b000, 
          S1 = 3'b001, 
          S2 = 3'b011, 
          S3 = 3'b010, 
          S4 = 3'b110; 
          
reg [2:0] p_state,n_state;

//present state logic
always @(posedge clk)
 begin
  if (!rstn)
  p_state <= S0;
  else
  p_state <= n_state;
 end

//Next state logic
always @(sequence,p_state)
 begin
 case(p_state)
 S0: begin
     if(sequence==1)
     n_state = S1;
     else
     n_state = S0;
     end
 S1: begin
     if(sequence==0)
     n_state = S2;
     else
     n_state = S1;
     end
 S2: begin
     if(sequence==0)
     n_state = S0;
     else
     n_state = S3;
     end
 S3: begin
     if(sequence==0)
     n_state = S2;
     else
     n_state = S4;
     end
 S0: begin
     if(sequence==0)
     n_state = S2;
     else
     n_state = S1;
     end
 default: n_state = S1;
 endcase
 end
 
//Combinational logic
always @(p_state)
 begin
 case(p_state)
 S0:      out = 0;
 S1:      out = 0;
 S2:      out = 0;
 S3:      out = 0;
 S4:      out = 1;
 default: out = 0;
 endcase
 end
endmodule
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
  
