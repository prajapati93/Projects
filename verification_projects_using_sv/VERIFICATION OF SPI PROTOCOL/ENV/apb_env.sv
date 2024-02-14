//-----------------------------------------------------------------------------
// Project name: Verification of APB Protocol
// Version: 1.0
// Description: Environment class for APB Protocol
// Author: Mehul Prajapati
//-----------------------------------------------------------------------------


class env;

  gen gen_h;
  drv drv_h;
  sco sco_h;
  mon mon_h;
  
  event nextgd; //G->D
  event nextgs; //G->S
  
  mailbox #(trans) gdmbx; 
  
  mailbox #(trans) msmbx;
  
  virtual apb_if vif;
    
  function new (virtual abp_if vif);
    gdmbx = new();
	gen_h = new(gdmbx);
	drv_h = new(gdmbx);
	
	msmbx = new();
	mon_h = new(msmbx);
	sco_h = new(msmbx);
	
	this.vif = vif;
	drv_h.vif = this.vif;
	mon_h.vif = this.vif;
	
	gen_h.nextsco = nextgs;
	sco_h.nextsco = nextgs;
	
	gen_h.nextdrv = nextgd;
	drv_h.nextdrv = nextgd;
	
  endfunction
  
  task pre_test();
    drv_h.reset();
  endtask
  
  task test();
  fork
    gen_h.run();
	drv_h.run();
	mon_h.run();
	sco_h.run();
  join_any
  endtask
  
  task post_test();
     wait(gen_h.done.triggered);
	 $finish();
  endtask
  
  task run();
     pre_test();
	 test();
	 post_test();
  endtask
  
endclass

