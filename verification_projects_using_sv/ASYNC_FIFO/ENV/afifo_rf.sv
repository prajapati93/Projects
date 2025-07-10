`ifndef AFIFO_RF
`define AFIFO_RF

class afifo_rf;
	
	//Transaction class handle
	afifo_trans t_h1, t_h2, t_h3;
	
	//Queue array
	bit [7:0] array [$:15];
	
	//Mailbox
	//To get data from monitor and to put data to scoreboard
	mailbox #(afifo_trans) mon_rf;
	mailbox #(afifo_trans) rf_sb;
	
	//Default constructor method
	function new (mailbox #(afifo_trans) mon_rf,
				  mailbox #(afifo_trans) rf_sb
				  );
	this.mon_rf  = mon_rf;
	this.rf_sb   = rf_sb;
	endfunction
	
	//Run method: to get transaction from ref model and monitor
	extern task run();
	//tasks to check and compare expected and actual data/flags	
	extern task write_check();
	extern task read_check();
	extern task pointer_check();
	//extern task predictor_logic();
	
endclass

task afifo_rf::run();
	forever begin
		mon_rf.get(t_h1); //data from ref model
		t_h2 = new t_h1;  //copy data
		rf_sb.put(t_h2); //data from monitor
		fork
			write_check();
			read_check();
			pointer_check();
			//predictor_logic();
		join
	end
endtask

task afifo_rf::write_check();
	if (t_h1.wr_en)
		begin
		if(array.size < 15)
			begin
				array.push_front(t_h1.din);
				$display("time:%0d, size: %0d, DIN: %0d",$time,array.size(), t_h1.din);
			end
		end
endtask

task afifo_rf::read_check();
	if (t_h1.rd_en)
		begin
			t_h1.exp_data = array.pop_back();
			$display("time:%0d, EXP_DATA: %0d",$time,t_h1.exp_data);
		end
endtask

task afifo_rf::pointer_check();
	begin
	if (t_h1.wr_en) 
		begin
			if (array.size() == 14)
			begin
			t_h1.exp_almost_full = 1;
			$display("EXP_ALMOST_FULL: %0d",t_h1.exp_almost_full);
			end
			else
			if (array.size() == 15)
			begin
			t_h1.exp_full = 1;
			$display("EXP_FULL: %0d",t_h1.exp_full);
			end
		end
	if (t_h1.rd_en) 
		begin
			if (array.size() == 1)
			begin
			t_h1.exp_almost_empty = 1;
			$display("EXP_ALMOST_EMPTY: %0d",t_h1.exp_almost_empty);
			end
			else 
			t_h1.exp_almost_empty = 0;
			
			if (array.size() == 0)
			begin
			t_h1.exp_empty = 1;
			$display("EXP_EMPTY: %0d",t_h1.exp_empty);
			end
			else
			t_h1.exp_empty = 0;
		end
			
	end
endtask

/* task afifo_rf::predictor_logic();
	if (t_h1.rd_en)
		begin
		if(t_h1.exp_data = t_h1.dout)
			begin
				$display("[DATA MATCH] || EXP_DATA: %0d, DOUT: %0d  ||",t_h1.exp_data,t_h1.dout);
			end
		else
			$display("[DATA MIS-MATCH] ## EXP_DATA: %0d, DOUT: %0d ##",t_h1.exp_data,t_h1.dout);
		end
endtask */

`endif