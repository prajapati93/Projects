////////////////////////////////////////////////
// FIFO Verification in SV
// File description: monitor
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class fifo_monitor;

   fifo_trans trans_h;
   
   //mailbox
   mailbox #(fifo_trans) mon_rf;
   mailbox #(fifo_trans) mon_sb;
   
   virtual fifo_if.MON_MP vif;
   
   function new (mailbox #(fifo_trans) mon_rf,
                 mailbox #(fifo_trans) mon_sb,
                 virtual fifo_if.MON_MP vif);
        this.mon_rf = mon_rf;
		this.mon_sb = mon_sb;
		this.vif = vif;
	endfunction
	
	task run();
	  trans_h = new();
	  forever begin
	  mon_rf.put(trans_h);
	  mon_sb.put(trans_h);
	  monitor();
	  end
	endtask
	
	task monitor();
		@(vif.mon_cb);
		trans_h.wr_enb = vif.mon_cb.wr_enb;
		trans_h.rd_enb = vif.mon_cb.rd_enb;
		trans_h.data_out = vif.mon_cb.data_out;
		trans_h.full = vif.mon_cb.full;
		trans_h.empty = vif.mon_cb.empty;
		trans_h.count = vif.mon_cb.count;
		trans_h.reset = vif.mon_cb.reset;
	endtask

endclass