`ifndef AFIFO_GEN
`define AFIFO_GEN

class afifo_gen;
	
	//Transaction class handle
	afifo_trans t_h, t_h1;
	
	//Mailbox
	//To put data from gen to driver
	mailbox #(afifo_trans) gen_drv;
	
	//Default constructor method
	function new (mailbox #(afifo_trans) gen_drv
				  );
			this.gen_drv = gen_drv;
	endfunction
	
	//Run method: to put transaction from gen_drv via mailbox
	virtual task run();
		t_h = new();
		repeat(iteration)begin
			assert(t_h.randomize() with {wr_en==1; rd_en==0; clear_n==1;});
			t_h1 = new t_h;
			gen_drv.put(t_h1);
		end
		repeat(iteration)begin
			assert(t_h.randomize() with {wr_en==0; rd_en==1; clear_n==1;});
			t_h1 = new t_h;
			gen_drv.put(t_h1);
		end
	endtask
	
endclass


`endif