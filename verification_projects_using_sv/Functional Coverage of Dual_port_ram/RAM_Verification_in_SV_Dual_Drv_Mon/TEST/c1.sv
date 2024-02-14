////////////////////////////////////////////////
// RAM Verification in SV
// File description: Testcase for reset.
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class ram_reset_test extends ram_gen;

  function new(mailbox #(ram_trans) gen_wd,
               mailbox #(ram_trans) gen_rd);
	super.new(gen_wd,gen_rd);
  endfunction
  
  task run();
    trans_h = new;
	//RESET
	repeat(2) 
	begin
	   trans_h.rst = ~trans_h.rst;
	   put_trans();
	end
	
	//WRITE
	repeat(10)
	begin
	assert(trans_h.randomize() with {trans_kind_e == WRITE;});
		put_trans();
	end
	
	//RESET
	repeat(2) 
	begin
	   trans_h.rst = ~trans_h.rst;
	   put_trans();
	end
	
	//READ
	repeat(10)
	begin
	assert(trans_h.randomize() with {trans_kind_e == READ;});
		put_trans();
	end
	
	//RESET HIGH
	trans_h.rst = ~trans_h.rst;
	put_trans();
	repeat(10)
	begin
	assert(trans_h.randomize() with {trans_kind_e == WRITE;});
		put_trans();
	end
	repeat(10)
	begin
	assert(trans_h.randomize() with {trans_kind_e == READ;});
		put_trans();
	end

 endtask
endclass