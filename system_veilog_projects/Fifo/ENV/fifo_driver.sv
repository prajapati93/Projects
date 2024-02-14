////////////////////////////////////////////////
// FIFO Verification in SV
// File description: Driver & mailbox
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class fifo_driver;

  fifo_trans trans_h;
  
  //mailbox
  mailbox #(fifo_trans) gen_driver;
  mailbox #(fifo_trans) dri_rf;
  
  //interface
  virtual fifo_if.DR_MP vif;
  
  function new (mailbox #(fifo_trans) gen_driver,
				mailbox #(fifo_trans) dri_rf,
				virtual fifo_if.DR_MP vif);
		this.gen_driver = gen_driver;
		this.dri_rf = dri_rf;
		this.vif = vif;
  endfunction
  
  task run();
    trans_h = new();
	forever begin
	   gen_driver.get(trans_h);
	   dri_rf.put(trans_h);
	   //$display("WR Driver : wr_enb = %0d, rd_enb = %0d, data_in = %0d", trans_h.wr_enb,trans_h.rd_enb,trans_h.data_in);
	   send_to_dut();
	   end
   endtask
   
   task send_to_dut();
    @(vif.dri_cb);
	vif.dri_cb.wr_enb  <= trans_h.wr_enb;
	vif.dri_cb.rd_enb  <= trans_h.rd_enb;
	vif.dri_cb.data_in <= trans_h.data_in;
   endtask

endclass