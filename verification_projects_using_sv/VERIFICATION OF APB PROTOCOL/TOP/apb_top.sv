//-----------------------------------------------------------------------------
// Project name: Verification of APB Protocol
// Version: 1.0
// Description: Top module for APB Protocol
// Author: Mehul Prajapati
//-----------------------------------------------------------------------------

module top;
   import apb_pkg::*;
   
   bit pclk;
   
   apb_if vif();
      
   apb_ram dut (vif.pclk,
			  vif.preset_n,
			  vif.psel,
			  vif.penable,
			  vif.pwrite,
			  vif.paddr,
			  vif.pwdata,
			  vif.prdata,
			  vif.pready, 
			  vif.pslverr);
			  
   initial begin
       vif.pclk <= 0;
   end
   
   always #10 vif.pclk <= ~vif.pclk;
   
   env env_h;
   
   initial begin
        env_h = new(vif);
		env_h.gen_h.count = 30;
		env_h.run();
   end
   	
endmodule