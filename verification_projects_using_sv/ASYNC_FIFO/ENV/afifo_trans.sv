`ifndef FIFO_TRANS
`define FIFO_TRANS

`include "afifo_defines.sv"

class afifo_trans;

	//Define variable
	rand bit clear_n;
	
	//Write Signals
	rand bit wr_en;
	bit wr_ack, wr_err, full, almost_full;
	rand bit [`WIDTH-1:0] din;

	//Read Signals
	rand bit rd_en;
	bit rd_ack, rd_err, empty, almost_empty;
	rand bit [`WIDTH-1:0] dout;
	
	//Pointers
	bit [3:0] wr_ptr;
	bit [3:0] rd_ptr;
	
	//Memory
	logic [`WIDTH-1:0] mem [0:`DEPTH-1];
	
	//Expected Data
	bit [`WIDTH-1:0] exp_data;
	bit exp_full;
	bit exp_almost_full;
	bit exp_empty;
	bit exp_almost_empty;
	bit exp_flag;
	bit exp_wr_ack;
	bit exp_rd_ack;
	bit exp_wr_err;
	bit exp_rd_err;
	
endclass

`endif