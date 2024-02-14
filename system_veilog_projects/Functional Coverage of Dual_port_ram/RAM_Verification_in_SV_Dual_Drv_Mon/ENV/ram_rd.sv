////////////////////////////////////////////////
// RAM Verification in SV
// File description: It converts transaction state into pin level state.
//                   It drives read signals to DUT.
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class ram_rd;

 ram_trans trans_h;
 
 //mailbox
  mailbox #(ram_trans) gen_rd;

 //interface
 virtual ram_if.RDR_MP vif;


 function new (mailbox #(ram_trans) gen_rd, 
               virtual ram_if.RDR_MP vif);
	this.gen_rd = gen_rd;
	this.vif = vif;
 endfunction
 
/* Run task will get data from gen_drv mailbox into trans_h object.
   send_to_dut task is called in this.
*/ 
 task run();
   //repeat(50) begin
   forever begin
     gen_rd.get(trans_h);
	 send_to_dut();
	 //trans_h.print();
	 //trans_h.rd_display();
    end
 endtask
 
 task send_to_dut();
   @(vif.rdr_cb);
   vif.rdr_cb.rd_enb <= trans_h.rd_enb;
   //vif.rdr_cb.rd_enb <=  (trans_h.trans_kind_e == READ || trans_h.trans_kind_e == SIM_RW) ? 1'b1 : 1'b0;
   vif.rdr_cb.rd_addr <= trans_h.rd_addr;
 endtask
 
endclass