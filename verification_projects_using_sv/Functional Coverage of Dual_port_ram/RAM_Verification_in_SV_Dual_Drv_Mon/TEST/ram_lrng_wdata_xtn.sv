////////////////////////////////////////////////
// RAM Verification in SV
// File description: Testcase for low range data.
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

`ifndef RAM_LRNG_WDATA_XTN_SV
`define RAM_LRNG_WDATA_XTN_SV

class ram_lrng_wdata_xtn extends ram_gen;

  function new (mailbox #(ram_trans) gen_wd,
                mailbox #(ram_trans) gen_rd);
		super.new(gen_wd,gen_rd);
  endfunction
  
  task run();
    repeat(32) begin
	if (!trans_h.randomize() with {wr_data < 100;})
	    $error("RAM_GEN","RANDOMIZATION FAILED!");
	  put_trans();
	  end
  endtask
  
endclass

`endif
