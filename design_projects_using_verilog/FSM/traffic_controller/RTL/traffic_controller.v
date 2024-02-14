
//TRAFFIC CONTROLLER FOR HIGHWAY & COUNTRY RD

`define RED    2'd0
`define YELLOW 2'd1
`define GREEN  2'd2

//Define states
`define S0   3'd0    //H-WAY=G  COUNTRY=R
`define S1   3'd1    //H-WAY=Y  COUNTRY=R
`define S2   3'd2    //H-WAY=R  COUNTRY=R
`define S3   3'd4    //H-WAY=R  COUNTRY=G
`define S4   3'd5    //H-WAY=R  COUNTRY=Y

//Define delayss
`define Y2R_DELAY 3  //Yellow to red
`define R2G_DELAY 2  //Red to Green

module traffic_controller (highway,country,ctrl,clk,clear);

//Ports declaration
output reg [1:0] highway,country; //2-bit output for 3 states of signal
input ctrl,clk,clear; //if ctrl=1 then car is present on country road

reg [2:0] p_state, n_state;

//Traffic controller starts in S0 state
initial begin
  p_state = `S0;
  n_state = `S0;
  highway = `GREEN;
  country = `RED;
  end
  
always @(posedge clk)
  p_state = n_state;
  
always @(p_state)
 begin
   case(p_state)
     `S0: begin
          highway = `GREEN;
          country = `RED;
          end
     `S1: begin
          highway = `YELLOW;
          country = `RED;
          end
     `S2: begin
          highway = `RED;
          country = `RED;
          end
     `S3: begin
          highway = `RED;
          country = `GREEN;
          end
     `S4: begin
          highway = `RED;
          country = `YELLOW;
          end
   endcase
  end
  
//
always @(p_state or clear or ctrl)
 begin
   if(clear)
     n_state = `S0;
     else
     case (p_state)
       `S0: if (ctrl)
            n_state = `S1;
            else
            n_state = `S0;
       `S1: begin
            repeat (`Y2R_DELAY) @(posedge clk);
            n_state = `S2;
            end
       `S2: begin
            repeat (`R2G_DELAY) @(posedge clk);
            n_state = `S3;
            end
       `S3: if (ctrl)
            n_state = `S3;
            else
            n_state = `S4;
       `S4: begin
            repeat (`Y2R_DELAY) @(posedge clk);
            n_state = `S0;
            end
       default: n_state = `S0;
     endcase
 end
 
 endmodule
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
