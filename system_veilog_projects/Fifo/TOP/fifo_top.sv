////////////////////////////////////////////////
// FIFO Verification in SV
// File description: TOP module for FIFO
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

`include "../TEST/fifo_test.sv"

module top();

import fifo_pkg::*;
  
  bit clk;
  
  fifo_test test_h;
  
  fifo_if inf(clk);
  
  //DUT instantiation
   fifo DUT (.clk(clk),
			.rst(inf.reset),
			.wr_enb(inf.wr_enb),
			.rd_enb(inf.rd_enb),
			.data_in(inf.data_in),
			.data_out(inf.data_out),
			.empty(inf.empty),
			.full(inf.full),
			.count(inf.count));
	
    always
    #5 clk = ~clk;

    initial begin
    test_h = new(inf,inf);
	@(posedge clk);
	inf.dri_cb.reset <= 0;
	@(posedge clk);
	inf.dri_cb.reset <= 1;
	/* inf.dri_cb.wr_enb <= 0;
	inf.dri_cb.rd_enb <= 0;
	inf.dri_cb.data_in <= 0;*/
	@(posedge clk);
	@(posedge clk);
	inf.dri_cb.reset <= 0;
	test_h.build_and_run();
	#500;
	$finish;
	end
	
endmodule
  
  