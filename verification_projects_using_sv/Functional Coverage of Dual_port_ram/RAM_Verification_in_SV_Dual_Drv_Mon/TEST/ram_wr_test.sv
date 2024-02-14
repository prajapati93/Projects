////////////////////////////////////////////////
// RAM Verification in SV
// File description: Testcase for only write.
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class ram_wr_test extends ram_gen;

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
	
	repeat(16)
	begin
	if(!trans_h.randomize() with {trans_kind_e == WRITE;});
	   $error("ERROR!!");
	   put_trans();
	end

 endtask
endclass