`include "afifo_defines.sv"
interface afifo_interface(input bit wr_clk, rd_clk);

	//Global signal
	logic clear_n;
	
	//Write signals
	logic wr_en;
	logic wr_ack, wr_err;
	logic full, almost_full;
	logic [`WIDTH-1:0] din;
	
	//Read signals
	logic rd_en;
	logic rd_ack, rd_err;
	logic empty, almost_empty;
	logic [`WIDTH-1:0] dout;
	
	//Clocking block for Write Driver
	clocking wr_drv_cb @(posedge wr_clk);
		default input #1 output #0;
		input wr_ack,wr_err,full,almost_full;
		output clear_n,din,wr_en;
	endclocking
	
	//Clocking block for Read Driver
	clocking rd_drv_cb @(posedge rd_clk);
		default input #1 output #0;
		input rd_ack,rd_err,empty,almost_empty;
		output clear_n,rd_en;
	endclocking
	
	//Clocking block for Write monitor
	clocking wr_mon_cb @(negedge wr_clk);
		default input #0 output #1;
		input wr_ack,wr_err,full,almost_full,clear_n,din,wr_en;
	endclocking
	
	//Clocking block for Read monitor
	clocking rd_mon_cb @(negedge rd_clk);
		default input #0 output #1;
		input rd_ack,rd_err,empty,almost_empty,clear_n,dout,rd_en;
	endclocking
	
	//Modport for Driver and monitor
	modport WR_DRV_MP (clocking wr_drv_cb);
    modport RD_DRV_MP (clocking rd_drv_cb);
    modport WR_MON_MP (clocking wr_mon_cb);
    modport RD_MON_MP (clocking rd_mon_cb);

endinterface