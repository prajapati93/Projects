//-----------------------------------------------------------------------------
// Project name: Verification of APB Protocol
// Version: 1.0
// Description: Transaction class for APB Protocol
// Author: Mehul Prajapati
//-----------------------------------------------------------------------------


class trans;

  typedef enum int {write = 0, read = 1, random = 2, error = 3} op_type;
  
  randc op_type oper;
  rand bit [31:0] paddr;
  rand bit [31:0] pwdata;
  rand bit psel;
  rand bit penable;
  rand bit pwrite;
  bit [31:0] prdata;
  bit pready;
  bit pslverr;
  
  constraint addr_c {paddr > 1; paddr < 5;}
  
  constraint data_c {pwdata>1; pwdata < 10;}
  
  function void display(input string tag);
    $display("[%0s] : OP :%0s paddr :%0d pwdata :%0d psel :%0b penable :%0b pwrite :%0b prdata :%0d pready :%0b pslverr :%0b",
	tag,oper.name(),paddr,pwdata,psel,penable,pwrite,prdata,pready,pslverr);
  endfunction
  
  function trans copy();
    copy = new();
	copy.oper = this.oper;
    copy.paddr = this.paddr;
	copy.pwdata = this.pwdata;
	copy.psel = this.psel;
	copy.penable = this.penable;
	copy.pwrite = this.pwrite;
	copy.prdata = this.prdata;
	copy.pready = this.pready;
	copy.pslverr = this.pslverr;
  endfunction
  
endclass