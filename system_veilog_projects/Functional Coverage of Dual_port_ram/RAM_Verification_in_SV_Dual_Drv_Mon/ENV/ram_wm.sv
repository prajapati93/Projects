////////////////////////////////////////////////
// RAM Verification in SV
// File description: To monitor data coming from write driver and send to refernce model for prediction.
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class ram_wm;

  ram_trans trans_h;
  
  mailbox #(ram_trans) wm_rf;
  
  virtual ram_if.WMON_MP vif;
  
  //
   function new (mailbox #(ram_trans) wm_rf, 
               virtual ram_if.WMON_MP vif);
	this.wm_rf = wm_rf;
	this.vif = vif;
 endfunction
 
 task run();
  //repeat(10) begin
   forever begin
   monitor();
   wm_rf.put(trans_h);
   trans_h.print();
   //trans_h.wm_display();
  end
 endtask
 
 
 task monitor();
   //create trans_h
   @(vif.wmon_cb);
   trans_h = new;
   trans_h.wr_enb  = vif.wmon_cb.wr_enb;
   trans_h.wr_addr = vif.wmon_cb.wr_addr;
   trans_h.wr_data = vif.wmon_cb.wr_data;
 endtask
 
endclass