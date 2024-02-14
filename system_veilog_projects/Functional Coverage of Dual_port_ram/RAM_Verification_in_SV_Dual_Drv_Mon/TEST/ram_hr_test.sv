////////////////////////////////////////////////
// RAM Verification in SV
// File description: Testcase for High range data.
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class ram_hr_test extends ram_gen;

  function new(mailbox #(ram_trans) gen_wd,
               mailbox #(ram_trans) gen_rd);
	super.new(gen_wd,gen_rd);
  endfunction
  
  task run();
    trans_h = new;
	repeat(2) 
	begin
	   trans_h.rst = ~trans_h.rst;
	   put_trans();
	end
	
	repeat(5)
	begin
	assert(trans_h.randomize() with {trans_kind_e == WRITE;
	               wr_addr inside {[10:15]};
				   wr_addr == rd_addr;});
		put_trans();
		trans_h.trans_kind_e = READ;
		put_trans();
	end
 endtask
endclass