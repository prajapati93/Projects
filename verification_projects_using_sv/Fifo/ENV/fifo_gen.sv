////////////////////////////////////////////////
// FIFO Verification in SV
// File description: gen
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class fifo_gen;

  fifo_trans trans_h;
  
  //mailbox
  mailbox #(fifo_trans) gen_driver;
  
  function new (mailbox #(fifo_trans) gen_driver);
    this.gen_driver = gen_driver;
  endfunction
  
  task run();
  
    repeat (30) begin
	  trans_h = new();
	  assert(trans_h.randomize() with {wr_enb == 1; rd_enb == 1;});
	  gen_driver.put(trans_h);
	  //$display("Gen: data_in: %0d",trans_h.data_in);	  
	end

    repeat (30) begin
	  trans_h = new();
	  assert(trans_h.randomize() with {wr_enb == 1; rd_enb == 0;});
	  gen_driver.put(trans_h);
	  //$display("Gen: data_in: %0d",trans_h.data_in);	  
	end
   
   endtask

endclass
