//-----------------------------------------------------------------------------
// Project name: Verification of APB Protocol
// Version: 1.0
// Description: Driver class for APB Protocol
// Author: Mehul Prajapati
//-----------------------------------------------------------------------------


class drv;

  virtual apb_if vif;
  
  mailbox #(trans) mbx;
  trans datac;
  event nextdrv;
  
  function new(mailbox #(trans) mbx);
    this.mbx = mbx;
  endfunction
  
  task reset();
    vif.preset_n <= 1'b0;
	vif.pel <= 1'b0;
	vif.penable <= 1'b0;
	vif.pwdata <= 0;
	vif.paddr <= 0;
	vif.pwrite <= 1'b0;
	repeat(5) @(posedge vif.pclk);
	vif.preset_n <= 1'b1;
	repeat(5) @(posedge vif.pclk);
	$display("[DRV] : RESET DONE!");
  endtask
  
  task run();
    forever begin
	mbx.get(datac);
	
	if(datac.oper == 0) //write
	   begin
	   @(posedge vif.pclk);
	      vif.psel <= 1'b1;
		  vif.penable <= 1'b0;
		  vif.pwdata <= datac.pwdata;
		  vif.paddr <= datac.paddr;
		  vif.pwrite <= 1'b1;
	   @(posedge vif.pclk);
	      vif.penable <= 1'b1;
	   repeat(2) @(posedge vif.clk);
	      vif.pel <= 1'b0;
		  vif.penable <= 1'b0;
		  vif.pwrite <= 1'b0;
		  $display("[DRV] : DATA WRITE OP data: %0d and addr: %0d",datac.pwdata,datac.paddr);
	   end
	else if (datac.oper == 1) //read
	   begin
	   @(posedge vif.pclk);
	      vif.psel <= 1'b1;
		  vif.penable <= 1'b0;
		  vif.pwdata <= datac.pwdata;
		  vif.paddr <= datac.paddr;
		  vif.pwrite <= 1'b0;
	   @(posedge vif.pclk);
	      vif.penable <= 1'b1;
	   repeat(2) @(posedge vif.clk);
	      vif.pel <= 1'b0;
		  vif.penable <= 1'b0;
		  vif.pwrite <= 1'b0;
		  $display("[DRV] : DATA READ OP data: %0b",datac.paddr);
	   end
	else if (datac.oper == 2) //random  
	   begin
	   @(posedge vif.pclk);
	      vif.psel <= 1'b1;
		  vif.penable <= 1'b0;
		  vif.pwdata <= datac.pwdata;
		  vif.paddr <= datac.paddr;
		  vif.pwrite <= datac.pwrite;
	   @(posedge vif.pclk);
	      vif.penable <= 1'b1;
	   repeat(2) @(posedge vif.clk);
	      vif.pel <= 1'b0;
		  vif.penable <= 1'b0;
		  vif.pwrite <= 1'b0;
		  $display("[DRV] : RANDOM OPERATIONN");
	   end
	else if (datac.oper == 3) //slverr
	   begin
	   @(posedge vif.pclk);
	      vif.psel <= 1'b1;
		  vif.penable <= 1'b0;
		  vif.pwdata <= datac.pwdata;
		  vif.paddr <= $urandom_range(32,100);
		  vif.pwrite <= datac.pwrite;
	   @(posedge vif.pclk);
	      vif.penable <= 1'b1;
	   repeat(2) @(posedge vif.clk);
	      vif.pel <= 1'b0;
		  vif.penable <= 1'b0;
		  vif.pwrite <= 1'b0;
		  $display("[DRV] : SOLVE  ERROR");
	   end
	   
	   ->nextdrv;
	end
  endtask
  
endclass