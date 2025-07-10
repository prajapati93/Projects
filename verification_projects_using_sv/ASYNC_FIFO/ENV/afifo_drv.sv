`ifndef AFIFO_DRV
`define AFIFO_DRV

class afifo_drv;
	
	//Transaction class handle
	afifo_trans t_h, t_h1;
	
	//Virtual interface handle
	virtual afifo_interface.WR_DRV_MP wvif;
	virtual afifo_interface.RD_DRV_MP rvif;
	
	//Mailbox
	//To get data from gen to driver
	mailbox #(afifo_trans) gen_drv;
	
	//Default constructor method
	function new (virtual afifo_interface.WR_DRV_MP wvif,
				  virtual afifo_interface.RD_DRV_MP rvif,
				  mailbox #(afifo_trans) gen_drv
				  );
	this.wvif    = wvif;
	this.rvif    = rvif;
	this.gen_drv = gen_drv;
	endfunction
	
	//Run method: to get transaction from gen_drv via mailbox
	extern task run();
	//tasks to send the transaction to dut using interface	
	extern task send_to_dut_with_wr_clk();
	extern task send_to_dut_with_rd_clk();
	
endclass

task afifo_drv::run();
	forever begin
		gen_drv.get(t_h);
		t_h1 = new t_h;
		fork
		send_to_dut_with_wr_clk();
		send_to_dut_with_rd_clk();  
		join
	end
endtask

task afifo_drv::send_to_dut_with_wr_clk();
	@(wvif.wr_drv_cb)
	wvif.wr_drv_cb.clear_n <= t_h.clear_n;
	wvif.wr_drv_cb.wr_en   <= t_h.wr_en;
	wvif.wr_drv_cb.din     <= t_h.din;
	//$display("time=%0d,@wr_clk [DRV DATA]: wr_en: %0d, din: %0d",$time,wvif.wr_drv_cb.wr_en,wvif.wr_drv_cb.din);
endtask

task afifo_drv::send_to_dut_with_rd_clk();
	@(rvif.rd_drv_cb)
	rvif.rd_drv_cb.clear_n <= t_h.clear_n;
	rvif.rd_drv_cb.rd_en   <= t_h.rd_en;
	//$display("time=%0d,@rd_clk [DRV DATA]: rd_en: %0d",$time,rvif.rd_drv_cb.rd_en);
endtask


`endif