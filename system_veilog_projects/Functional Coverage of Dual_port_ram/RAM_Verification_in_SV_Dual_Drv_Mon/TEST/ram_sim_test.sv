////////////////////////////////////////////////
// RAM Verification in SV
// File description: Testcase for simultaneous read and write.
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class ram_sim_test extends ram_gen;

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
	
	repeat(32)
	begin
	if(!trans_h.randomize() with {trans_kind_e == SIM_RW;});
	   $error("ERROR!!");
	   put_trans();
	end

 endtask
endclass