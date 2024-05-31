//-----------------------------------------------------------------------------
// Project name: Verification of APB Protocol
// Version: 1.0
// Description: Design module for APB Protocol
// Author: Mehul Prajapati
//-----------------------------------------------------------------------------

`define PADDR 32
`define PDATA 32

module apb_ram (

  input pclk,
  input preset_n,
  input psel,
  input penable,
  input pwrite,
  input [(`PADDR-1):0] paddr,
  input [(`PDATA-1):0] pwdata,
 
  output reg [(`PDATA-1):0] prdata,
  output reg pready, pslverr
  );
  
  reg [31:0] mem [32];
  
  //Declaring FSM states for operation
  typedef enum {idle=0, setup=1, access=2, transfer=3} state_type;
  
  state_type state = idle;
  
  always @(posedge pclk)
    begin
    if(preset_n == 1'b0)  //active low reset
	    begin
	    state <= idle;
		prdata <= 32'h0;
		pready <= 1'b0;
		pslverr <= 1'b0;
		
			for (int i=0; i<32; i++)
			begin
				mem[i]<=0;
			end
		end
	
	else begin
		
	case(state)
	//initialized pins to zero for idle state
	idle:
		begin
	        prdata <= 32'h0;
			pready <= 1'b0;
			pslverr <= 1'b0;
			
			if((psel==1'b0) && (penable==1'b0))
			    begin
				state <= setup;
				end
		end
	//start of transaction
	setup:
		begin
		    if((psel==1'b1) && (penable==1'b0))
			begin
			    if(paddr<32) begin
				state <= access;
				pready <= 1'b1;
				end
				
				else begin
				state <= access;
				pready<=1'b0;
				end
			end
			
       		else
			state<=setup;
		end
	//
	access:
		begin
		    if(psel && pwrite && penable)
			begin
				if(paddr<32) begin
				mem[paddr] <= pwdata;
				state <= transfer;
				pslverr <= 1'b0;
				end
				
				else begin
				state <= transfer;
				pready <= 1'b1;
				pslverr <= 1'b1;
				end
			end
			
			else if (psel && !pwrite && penable)
			begin
			    if(paddr<32) begin
				prdata <= mem[paddr];
				state <= transfer;
				pready <= 1'b1;
				pslverr <= 1'b0;
				end
				
				else begin
				state <= transfer;
				pready <= 1'b1;
				pslverr <= 1'b1;
				prdata <= 32'hx;
				end
			end
		end
	//
	transfer:
		begin
		state <= setup;
		pready <= 1'b0;
		pslverr <= 1'b0;
		end
		
	default: state <= idle;
		
	endcase
		
    end
		
	end
endmodule
		
	
