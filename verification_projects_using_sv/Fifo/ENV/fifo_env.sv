////////////////////////////////////////////////
// FIFO Verification in SV
// File description: env
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class fifo_env;
 
   fifo_gen     gen_h;
   fifo_driver  dri_h;
   fifo_monitor mon_h;
   fifo_rf      rf_h;
   fifo_sb      sb_h;

   //mailbox
   mailbox #(fifo_trans) gen_driver = new();
   mailbox #(fifo_trans) mon_rf = new();
   mailbox #(fifo_trans) dri_rf = new();
   mailbox #(fifo_trans) mon_sb = new();
   mailbox #(fifo_trans) rf_sb = new();
   
   //interface
   virtual fifo_if.DR_MP dri_if;
   virtual fifo_if.MON_MP mon_if;
   
   function new (virtual fifo_if.DR_MP dri_if,
                 virtual fifo_if.MON_MP mon_if);
		this.dri_if = dri_if;
		this.mon_if = mon_if;
   endfunction
   
   function void build();
     gen_h = new(gen_driver);
	 dri_h = new(gen_driver,dri_rf,dri_if);
	 mon_h = new(mon_rf,mon_sb,mon_if);
	 rf_h = new(dri_rf,mon_rf,rf_sb);
	 sb_h = new(rf_sb,mon_sb);
   endfunction
   
   task run();
     fork
	  gen_h.run();
	  dri_h.run();
	  mon_h.run();
	  rf_h.run();
	  sb_h.run();
	 join_none
   endtask

endclass