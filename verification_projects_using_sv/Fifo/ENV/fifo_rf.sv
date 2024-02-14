////////////////////////////////////////////////
// FIFO Verification in SV
// File description: reference model
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class fifo_rf;

  fifo_trans trans_h1, trans_h2;
  
  logic [2:0] wr_ptr=0, rd_ptr=0;
  
  //mailbox
  mailbox #(fifo_trans) dri_rf;
  mailbox #(fifo_trans) mon_rf;
  mailbox #(fifo_trans) rf_sb;
  
  function new (mailbox #(fifo_trans) dri_rf,
                mailbox #(fifo_trans) mon_rf,
                mailbox #(fifo_trans) rf_sb);
		this.dri_rf = dri_rf;
		this.mon_rf = mon_rf;
		this.rf_sb = rf_sb;
   endfunction
   
   task run();
     trans_h2 = new();
	 forever begin
	 //trans_h1 = new();
	 dri_rf.get(trans_h1);
	 mon_rf.get(trans_h2);
	 ref_model();
	 rf_sb.put(trans_h2);
	 end
   endtask
   
   task ref_model();
   
   fork
     begin
	   if (trans_h1.rd_enb && !trans_h2.empty)
	       trans_h2.exp_data = trans_h2.temp_ram[rd_ptr];
	   else if (trans_h1.rd_enb && trans_h1.wr_enb)
	       trans_h2.exp_data = trans_h2.temp_ram[wr_ptr];
	 end
	 begin
	   if (trans_h1.wr_enb && !trans_h2.full)
	       trans_h2.temp_ram[wr_ptr] = trans_h1.data_in;
	   else if (trans_h1.wr_enb && trans_h1.rd_enb)
	       trans_h2.temp_ram[wr_ptr] = trans_h1.data_in;
	 end
	 begin
	   if (trans_h1.reset)
	      begin
		    wr_ptr = 0;
			rd_ptr = 0;
		  end
		else
		  begin
		     wr_ptr = ((trans_h1.wr_enb && !trans_h2.full) || (trans_h1.wr_enb && trans_h1.rd_enb)) ? wr_ptr+1 : wr_ptr;
			 rd_ptr = ((trans_h1.rd_enb && !trans_h2.empty) || (trans_h1.wr_enb && trans_h1.rd_enb)) ? rd_ptr+1 : rd_ptr;
          end
	 end
   join_none

  endtask 
	

endclass