//-----------------------------------------------------------------------------
// Project name: Verification of APB Protocol
// Version: 1.0
// Description: Scoreboard class for APB Protocol
// Author: Mehul Prajapati
//-----------------------------------------------------------------------------


class sco;

  virtual apb_if vif;
  
  mailbox #(trans) mbx;
  trans tr;
  event nextsco;
  
  bit [31:0] pwdata [12] = '{default:0};
  bit [31:0] rdata;
  int index;
    
  function new(mailbox #(trans) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    
	forever begin
	mbx.get(tr);
	$display("[SCO]: DATA RECIEVED wdata:%0d rdata:%0d addr:%0d write:%0b",tr.pwdata,tr.prdata,tr.paddr,tr.pwrite);
	
	if ((tr.pwrite == 1'b1) && (tr.pslverr == 1'b0)) //Write access
        begin
		  pwdata[tr.paddr] = tr.pwdata;
		  $display("[SCO]: DATA STORED data:%0d addr:%0d",tr.pwdata,tr.paddr);
		end
	else if ((tr.pwrite == 1'b0) && (tr.pslverr == 1'b0)) //Read access
	    begin
		  rdata = pwdata[tr.paddr];
		  if(tr.paddr == rdata)
		   $display("[SCO] : DATA MATCHED");
		  else
		   $display("[SCO] : DATA MISMATCHED");
		end
	else if (tr.pslverr == 1'b1)
	    begin
		   $display("[SCO] : SLV ERROR DETECTED");
		end
	->nextsco;
	end
	
		   
  endtask
  
endclass

