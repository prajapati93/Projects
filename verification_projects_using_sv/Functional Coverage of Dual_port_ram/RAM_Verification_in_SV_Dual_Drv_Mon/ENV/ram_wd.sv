////////////////////////////////////////////////
// RAM Verification in SV
// File description: Write driver drives traffic as per design protocol
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

`ifndef RAM_WD_SV
`define RAM_WD_SV

class ram_wd;

 ram_trans trans_h;
 
 //mailbox
  mailbox #(ram_trans) gen_wd;

 //interface
 virtual ram_if.WDR_MP vif;


 function new (mailbox #(ram_trans) gen_wd, 
               virtual ram_if.WDR_MP vif);
	this.gen_wd = gen_wd;
	this.vif = vif;
 endfunction
 
 task run();
   //repeat(10) begin
   forever begin
     //@(vif.wdr_cb);
     gen_wd.get(trans_h);
	 send_to_dut();
	 trans_h.print();
	 //trans_h.wd_display();
    end
 endtask
 
 task send_to_dut();
   //@(vif.wdr_cb);
   //vif.wdr_cb.rst <= trans_h.rst;
   //vif.wdr_cb.wr_enb  <= (trans_h.trans_kind_e == WRITE || trans_h.trans_kind_e == SIM_RW) ? 1'b1 : 1'b0;;
   vif.wdr_cb.wr_enb <= trans_h.wr_enb;
   vif.wdr_cb.wr_addr <= trans_h.wr_addr;
   vif.wdr_cb.wr_data <= trans_h.wr_data;
 endtask
 
endclass

`endif