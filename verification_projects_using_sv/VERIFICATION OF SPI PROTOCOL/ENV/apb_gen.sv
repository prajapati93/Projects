//-----------------------------------------------------------------------------
// Project name: Verification of APB Protocol
// Version: 1.0
// Description: Generator class for APB Protocol
// Author: Mehul Prajapati
//-----------------------------------------------------------------------------


class gen;

  trans tr;
  
  mailbox #(trans) mbx;
  int count = 0;
  event nextdrv; //driver ompleted task of triggering interface
  event nextsco; //scoreboard completed its objective
  event done;
  
  function new(mailbox #(trans) mbx);
    this.mbx = mbx;
	tr=new();
  endfunction
  
  task run();
    repeat(count) begin
	   assert(tr.randomize()) else $error("Randomization failed!");
	   mbx.put(tr.copy);
	   tr.display("GEN");
	   @(nextdrv);
	   @(nextsco);
	end
	
	->done;
   
  endtask
  
endclass