////////////////////////////////////////////////
// RAM Verification in SV
// File description: Class for ram base test
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

//import ram_env_pkg::*;
 class ram_base_test;
 
  ram_env env_h;
  
  //Testcases
  ram_wr_test wr_test;
  ram_sim_test sim_test;
  ram_rst_test rst_test;
  ram_mem_test mem_test;
  ram_lr_test lr_test;
  ram_hr_test hr_test;
  
  //interface
  virtual ram_if.WDR_MP  wd_if;
  virtual ram_if.RDR_MP  rd_if;
  virtual ram_if.WMON_MP wm_if;
  virtual ram_if.RMON_MP rm_if;
   
   
  function new (virtual ram_if.WDR_MP  wd_if,
                virtual ram_if.RDR_MP  rd_if,
                virtual ram_if.WMON_MP wm_if,
                virtual ram_if.RMON_MP rm_if);
	this.wd_if = wd_if;
	this.rd_if = rd_if;
	this.wm_if = wm_if;
	this.rm_if = rm_if;
  endfunction
  
  
  task build_and_run();
    env_h = new(wd_if,rd_if,wm_if,rm_if);
	env_h.build();
	if ($test$plusargs("WR_TEST")) begin
	  wr_test = new(env_h.gen_wd,env_h.gen_rd);
	  env_h.gen_h = wr_test;
	end
	
	if ($test$plusargs("SIM_TEST")) begin
	  sim_test = new(env_h.gen_wd,env_h.gen_rd);
	  env_h.gen_h = sim_test;
	end
	
	if ($test$plusargs("RST_TEST")) begin
	  rst_test = new(env_h.gen_wd,env_h.gen_rd);
	  env_h.gen_h = rst_test;
	end
	
	if ($test$plusargs("MEM_TEST")) begin
	  mem_test = new(env_h.gen_wd,env_h.gen_rd);
	  env_h.gen_h = mem_test;
	end
	
	if ($test$plusargs("LR_TEST")) begin
	  lr_test = new(env_h.gen_wd,env_h.gen_rd);
	  env_h.gen_h = lr_test;
	end
	
	if ($test$plusargs("HR_TEST")) begin
	  hr_test = new(env_h.gen_wd,env_h.gen_rd);
	  env_h.gen_h = hr_test;
	end
	
	env_h.run();
  endtask
  
endclass