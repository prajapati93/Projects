////////////////////////////////////////////////
// RAM Verification in SV
// File description: Generator class for stimulus/traffic which is further
//    used by driver through mailbox
//  - It can also provide traffic from external sources like files, DPI ports, etc.       
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

`ifndef RAM_GEN_SV
`define RAM_GEN_SV

//description
class ram_gen;

  ram_trans trans_h, trans_copy_h;
  
  //mailbox
  mailbox #(ram_trans) gen_wd;
  mailbox #(ram_trans) gen_rd;
  
  //description
  function new (mailbox #(ram_trans) gen_wd,
                mailbox #(ram_trans) gen_rd);
	this.gen_wd = gen_wd;
	this.gen_rd = gen_rd;
	trans_h = new();
  endfunction
  
  //description
  //pure virtual task run();
  virtual task run0();
  endtask
  
  task run();
      /*repeat(10) begin
	  trans_h = new();
	  $display("GEN: START");*/
	  repeat(50) begin
	  trans_h = new();
	  if (!trans_h.randomize())
	   $error("RAM_GEN","RANDOMIZATION FAILED");
	  gen_wd.put(trans_h);
	  gen_rd.put(trans_h);
	end
	$display("GEN: END");
 endtask
	   
	protected task put_trans();
	  trans_copy_h = new trans_h;
	  gen_wd.put(trans_copy_h);
	  gen_rd.put(trans_copy_h);
	endtask
	
endclass

`endif

