//-----------------------------------------------------------------------------
// Project name: Verification of APB Protocol
// Version: 1.0
// Description: Monitor class for APB Protocol
// Author: Mehul Prajapati
//-----------------------------------------------------------------------------


class mon;

  virtual apb_if vif;
  
  mailbox #(trans) mbx;
  trans tr;
    
  function new(mailbox #(trans) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    tr = new();
	forever begin
	   @(posedge vif.pclk);
	   if((vif.psel)&&(!vif.penable))
	   begin
	   //write access
	      @(posedge vif.pclk);
	      if(vif.psel && vif.pwrite && vif.penable)
			  begin
			  @(posedge vif.pclk);
			  tr.pwdata = vif.pwdata;
			  tr.paddr = vif.paddr;
			  tr.pwrite = vif.pwrite;
			  tr.pslverr = vif.pslverr;
			  $display("[MON] : DATA WRITE data:%0d and addr:%0d write:%0b",vif.pwdata,vif.paddr,vif.pwrite);
			  @(posedge vif.pclk);
			  end
	   //Read access
	      else if (vif.psel && !vif.pwrite && vif.penable)
			  begin
			  @(posedge vif.pclk);
			  tr.prdata = vif.prdata;
			  tr.pwrite = vif.pwrite;
			  tr.paddr = vif.paddr;
			  tr.pslverr = vif.pslverr;
			  $display("[MON] : DATA Read data:%0d and addr:%0d write:%0b",vif.prdata,vif.paddr,vif.pwrite);
			  @(posedge vif.pclk);
			  end
	      mbx.put(tr);
	   end
	end
		   
  endtask
  
endclass