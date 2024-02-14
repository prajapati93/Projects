////////////////////////////////////////////////
// FIFO Verification in SV
// File description: Signals description
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class fifo_trans;

	bit reset;
	
	//Output signals
	bit empty;
	bit full;
	bit [3:0] count;
	
	//Write signals
	rand bit [7:0] data_in;
	
	//Read signals
	bit [7:0] data_out;
	rand bit wr_enb;
	rand bit rd_enb;
	
	//Test signals
	reg [7:0] temp_ram [0:7];
	reg [7:0] exp_data;
	
	//constraint enb {wr_enb == 1; rd_enb ==1;}
	constraint enb {data_in < 100;}
	
endclass