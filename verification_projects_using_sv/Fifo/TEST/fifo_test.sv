////////////////////////////////////////////////
// FIFO Verification in SV
// File description: Test file
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

import fifo_pkg::*;

class fifo_test;

	fifo_env env_h;
	
	//interface
	virtual fifo_if.DR_MP dri_if;
	virtual fifo_if.MON_MP mon_if;
	
	function new (virtual fifo_if.DR_MP dri_if,
	              virtual fifo_if.MON_MP mon_if);
		this.dri_if = dri_if;
		this.mon_if = mon_if;
	endfunction
	
	task build_and_run ();
		env_h = new(dri_if,mon_if);
		env_h.build();
		env_h.run();
	endtask

endclass