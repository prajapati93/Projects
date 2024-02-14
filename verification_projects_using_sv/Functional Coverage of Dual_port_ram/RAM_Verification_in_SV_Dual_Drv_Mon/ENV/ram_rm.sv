////////////////////////////////////////////////
// RAM Verification in SV
// File description: To monitor data from interface. 
//                   to send data to scoreboard for comparison.
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////
class ram_rm;

  ram_trans trans_h;
  
  mailbox #(ram_trans) rm_rf;
  mailbox #(ram_trans) rm_sb;
  
  virtual ram_if.RMON_MP vif;
  
   function new (mailbox #(ram_trans) rm_rf, 
                 mailbox #(ram_trans) rm_sb, 
                 virtual ram_if.RMON_MP vif);
	this.rm_rf = rm_rf;
	this.rm_sb = rm_sb;
	this.vif = vif;
 endfunction
 
 task run();
  forever begin
//repeat(10) begin
   //@(vif.rmon_cb)
   monitor();
   rm_rf.put(trans_h);
   rm_sb.put(trans_h);
   trans_h.print();
   //trans_h.rm_display();
   #10;
  end
 endtask
 
 
 task monitor();
   //create trans_h
   @(vif.rmon_cb);
   trans_h = new();
   trans_h.rd_enb  = vif.rmon_cb.rd_enb;
   trans_h.rd_addr = vif.rmon_cb.rd_addr;
   trans_h.rd_data = vif.rmon_cb.rd_data;
   trans_h.wr_enb  = vif.rmon_cb.wr_enb;
   trans_h.wr_addr = vif.rmon_cb.wr_addr;
   trans_h.wr_data = vif.rmon_cb.wr_data;
 endtask
 
endclass