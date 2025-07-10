`ifndef AFIFO_SB
`define AFIFO_SB

class afifo_sb;
	
	//Transaction class handle
	afifo_trans t_h1, t_h2;
	
	//Coverage handle
	//afifo_coverage cv_h;
	
	//Mailbox
	//To get data from monitor and ref model
	mailbox #(afifo_trans) rf_sb;
	mailbox #(afifo_trans) mon_sb;
	
	//Default constructor method
	function new (mailbox #(afifo_trans) mon_sb,
				  mailbox #(afifo_trans) rf_sb
				  );
	this.mon_sb  = mon_sb;
	this.rf_sb   = rf_sb;
	endfunction
	
 	//Coverage
	covergroup cvg();
	
	din			: coverpoint t_h1.din{
					bins D0 = {[0:3]}; 
					bins D1 = {[4:7]};
					bins D2 = {[8:11]};
					bins D3 = {[12:15]};	 	 
							}
	
	wr_en		: coverpoint t_h1.wr_en{
					bins WREN_SET = (0 => 1);
					bins WREN_RST = (1 => 0);}
					
	rd_en		: coverpoint t_h1.rd_en{
					bins RDEN_SET = (0 => 1);
					bins RDEN_RST = (1 => 0);}

	full		: coverpoint t_h1.full{
					bins FULL_SET = (0 => 1)
					iff t_h1.wr_ptr == 16'hf;
					bins FULL_RST = (1 => 0)
					iff t_h1.wr_ptr < 14;}

	empty		: coverpoint t_h1.empty{
					bins EMPTY_SET = (0 => 1)
					iff t_h1.rd_ptr == 15;
					bins EMPTY_RST = (1 => 0)
					iff t_h1.rd_ptr < 14;}
					
	almost_empty: coverpoint t_h1.almost_empty{
					bins ALEM_SET = (0 => 1)
					iff t_h1.rd_ptr == 16'hd;
					bins ALEM_RST = (1 => 0)
					iff t_h1.rd_ptr < 12;}
					
	almost_full	: coverpoint t_h1.almost_full{
					bins ALFL_SET = (0 => 1)
					iff t_h1.wr_ptr == 16'hd;
					bins ALFL_RST = (1 => 0)
					iff t_h1.wr_ptr < 12;}
					
	wr_ack		: coverpoint t_h1.wr_ack {
					bins WRACK_SET = (0 => 1);
					bins WRACK_RST = (1 => 0);}

	rd_ack		: coverpoint t_h1.rd_ack {
					bins RDACK_SET = (0 => 1);
					bins RDACK_RST = (1 => 0);}

	wr_err		: coverpoint t_h1.wr_err {
					bins WRERR_SET = (0 => 1);
					bins WRERR_RST = (1 => 0);}
					
	rd_err		: coverpoint t_h1.rd_err {
					bins RDERR_SET = (0 => 1);
					bins RDERR_RST = (1 => 0);}
					
	clear_n		: coverpoint t_h1.clear_n {
					bins CLEAR_SET = (0 => 1);
					bins CLEAR_RST = (1 => 0);}
	//cross din, wr_en;
	//cross din, rd_en;
	//cross full, almost_full;
	//cross empty, almost_empty;
	endgroup 

	cvg = new();
	
	//Run method: to get transaction from ref model and monitor
	extern task run();
	//tasks to check and compare expected and actual data/flags	
	extern task predictor_logic();
	extern task flag_logic();
	
endclass

task afifo_sb::run();
	forever begin
		rf_sb.get(t_h1); //data from ref model
		mon_sb.get(t_h2); //data from monitor
		cvg.sample();
		predictor_logic();
		//flag_logic();
	end
endtask

task afifo_sb::predictor_logic();
	if (t_h1.rd_en)
		begin
		if(t_h1.exp_data == t_h1.dout)
			begin
				$display("----------------------------SCO-MATCH---------------------------------");
				$display("[DATA MATCH] || EXP_DATA: %0d, DOUT: %0d  ||",t_h1.exp_data,t_h1.dout);
			end
		else
			$display("------!!!!!!----------------SCO-MIS-MATCH----------------!!!!!!-------");
			$display("[DATA MIS-MATCH] ## EXP_DATA: %0d, DOUT: %0d ##",t_h1.exp_data,t_h1.dout);
		end
endtask

task afifo_sb::flag_logic();
	begin
		if (t_h1.full != 0)
		begin
		if (t_h1.full == t_h1.exp_full)
			$display("time=%0t full:%0d, Exp full:%0d",$time,t_h1.full,t_h1.exp_full);
		end
	end
	begin
		if (t_h1.almost_full != 0)
		begin
		if (t_h1.almost_full == t_h1.exp_almost_full)
			$display("time=%0t Almost full:%0d, Exp Almost full:%0d",$time,t_h1.almost_full,t_h1.exp_almost_full);
		end
	end
	begin
		if (t_h1.empty != 0)
		begin
		if (t_h1.empty == t_h1.exp_empty)
			$display("time=%0t empty:%0d, Exp empty:%0d",$time,t_h1.empty,t_h1.exp_empty);
		end
	end
	begin
		if (t_h1.almost_empty != 0)
		begin
		if (t_h1.almost_empty == t_h1.exp_almost_empty)
			$display("time=%0t Almost empty:%0d, Exp Almost empty:%0d",$time,t_h1.almost_empty,t_h1.exp_almost_empty);
		end
	end
endtask


`endif