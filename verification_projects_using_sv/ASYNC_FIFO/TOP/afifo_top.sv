
import afifo_pkg::*;

module top();

    //clocks	
	bit wr_clk, rd_clk;
	
	//test and transaction instance
	afifo_test test_h;
	afifo_trans t_h;
	
	//interface instance
	afifo_interface inf(wr_clk,rd_clk);
	
	//DUT Instantiation
	async_fifo DUT (.wr_clk(wr_clk),
				   .din(inf.din),
				   .wr_en(inf.wr_en),
				   .rd_clk(rd_clk),
				   .rd_en(inf.rd_en),
				   .clear_n(inf.clear_n),
				   .full(inf.full),
				   .almost_full(inf.almost_full),
				   .wr_ack(inf.wr_ack),
				   .wr_err(inf.wr_err),
				   .almost_empty(inf.almost_empty),
				   .empty(inf.empty),			   
				   .rd_ack(inf.rd_ack),
				   .rd_err(inf.rd_err),
				   .dout(inf.dout)
				);
     	
	
	always #7  wr_clk = ~wr_clk;
	always #5 rd_clk = ~rd_clk;
	
	initial begin
		inf.clear_n = 1;
		@(posedge wr_clk);
		inf.clear_n = 0;
		@(posedge wr_clk);
		inf.clear_n = 1;
		test_h = new(inf,inf,inf,inf);
		test_h.build_and_run();
		#1000 $finish;	
	end
	
	
endmodule: top