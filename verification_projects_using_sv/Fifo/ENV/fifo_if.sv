////////////////////////////////////////////////
// FIFO Verification in SV
// File description: interface
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

interface fifo_if(input bit clk);
    
	logic reset;
	logic empty;
	logic full;
	logic [3:0] count;
	
	//Write signals
	logic wr_enb;
	logic [7:0] data_in;
	
	//Read signals
	logic rd_enb;
	logic [7:0] data_out;
	
	//Write driver
	clocking dri_cb@(posedge clk);
	   default input #0 output #0;
	   output reset;
	   output wr_enb,rd_enb,data_in;
	endclocking
	
	//Read monitor
	clocking mon_cb@(posedge clk);
	   default input #0 output #0;
	   input reset;
	   input rd_enb,wr_enb,data_out,empty,full,count;
	endclocking
	
	modport DR_MP (clocking dri_cb);
	
	modport MON_MP (clocking mon_cb);
	
endinterface