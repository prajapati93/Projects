////////////////////////////////////////////////
// RAM Verification in SV
// File description: Importing package and class for top
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

import ram_pkg::*;
module ram_tb_top();

  bit clk;

  ram_base_test test_h;
  
  ram_if inf(clk);
  
  //dut instattiation
  ram DUT (.clk(clk),
           .rst(inf.rst),
		   .wr_enb(inf.wr_enb),
		   .wr_addr(inf.wr_addr),
		   .wr_data(inf.wr_data),
		   .rd_enb(inf.rd_enb),
		   .rd_addr(inf.rd_addr),
		   .rd_data(inf.rd_data));

 always
   #5 clk = ~clk;

  
  initial begin
   test_h = new(inf,inf,inf,inf);
   test_h.build_and_run();
   #500 $finish;
  end
  
endmodule