`ifndef AFIFO_MON
`define AFIFO_MON

class afifo_mon;
	
	//Transaction class handle
	afifo_trans t_h;
	
	//Virtual interface handle
	virtual afifo_interface.WR_MON_MP wvif;
	virtual afifo_interface.RD_MON_MP rvif;
	
	//Mailbox
	//To put data from mon to scoreboard and ref model
	mailbox #(afifo_trans) mon_sb;
	mailbox #(afifo_trans) mon_rf;
	
	//Default constructor method
	function new (virtual afifo_interface.WR_MON_MP wvif,
				  virtual afifo_interface.RD_MON_MP rvif,
				  mailbox #(afifo_trans) mon_sb,
				  mailbox #(afifo_trans) mon_rf
				  );
	this.wvif    = wvif;
	this.rvif    = rvif;
	this.mon_sb  = mon_sb;
	this.mon_rf  = mon_rf;
	endfunction
	
	//Run method: to get transaction from gen_drv via mailbox
	extern task run();
	//tasks to get the transaction from dut using interface	
	extern task get_from_dut_with_wr_clk();
	extern task get_from_dut_with_rd_clk();
	
endclass

task afifo_mon::run();
	t_h = new();
	forever begin
		fork
		get_from_dut_with_wr_clk();
		get_from_dut_with_rd_clk();		
		join
		mon_rf.put(t_h); //put data to ref model using mailbox
		mon_sb.put(t_h); //put data to scoreboard using mailbox
	end
endtask

task afifo_mon::get_from_dut_with_wr_clk();
	@(wvif.wr_mon_cb)
	t_h.wr_en       = wvif.wr_mon_cb.wr_en;
	t_h.wr_ack      = wvif.wr_mon_cb.wr_ack;
	t_h.wr_err      = wvif.wr_mon_cb.wr_err;
	t_h.full        = wvif.wr_mon_cb.full;
	t_h.almost_full = wvif.wr_mon_cb.almost_full;
	t_h.clear_n     = wvif.wr_mon_cb.clear_n;
	t_h.din         = wvif.wr_mon_cb.din;
	//$display("time=%0d,@wr_clk [MON DATA]: wr_en: %0d, wr_ack: %0d, wr_err: %0d, full: %0d, almost_full: %0d, clear_n: %0d, din: %0d",$time,t_h.wr_en,t_h.wr_ack,t_h.wr_err,t_h.full,t_h.almost_full,t_h.clear_n,t_h.din);
endtask

task afifo_mon::get_from_dut_with_rd_clk();
	@(rvif.rd_mon_cb)
	t_h.rd_en        = rvif.rd_mon_cb.rd_en;
	t_h.rd_ack       = rvif.rd_mon_cb.rd_ack;
	t_h.rd_err       = rvif.rd_mon_cb.rd_err;
	t_h.empty        = rvif.rd_mon_cb.empty;
	t_h.almost_empty = rvif.rd_mon_cb.almost_empty;
	t_h.clear_n      = rvif.rd_mon_cb.clear_n;
	t_h.dout         = rvif.rd_mon_cb.dout;
	//$display("time=%0d,@wr_clk [MON DATA]: wr_en: %0d, wr_ack: %0d, wr_err: %0d, full: %0d, almost_full: %0d, clear_n: %0d, din: %0d",$time,t_h.rd_en,t_h.rd_ack,t_h.rd_err,t_h.empty,t_h.almost_empty,t_h.clear_n,t_h.dout);
endtask


`endif