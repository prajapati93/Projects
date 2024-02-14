////////////////////////////////////////////////
// FIFO Verification in SV
// File description: svoreboard 
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class fifo_sb;

   fifo_trans trans_h1, trans_h2;
   
   //mailbox
   mailbox #(fifo_trans) rf_sb;
   mailbox #(fifo_trans) mon_sb;
   
    function new (mailbox #(fifo_trans) rf_sb,
                  mailbox #(fifo_trans) mon_sb);
	    this.rf_sb = rf_sb;
		this.mon_sb = mon_sb;
	endfunction
	
	task run();
	  forever begin
	    rf_sb.get(trans_h1);
		mon_sb.get(trans_h2);
		check_data();
	  end
	endtask
	
	task check_data();
	 wait (trans_h1.rd_enb == 0) begin
	  if(trans_h1.data_out == trans_h1.exp_data)
	  $display("SUCCESS! exp_data: %0d : %0d :data_out",trans_h1.exp_data,trans_h1.data_out);
	  //$display("exp_data: %0d : %0d = data_out", trans_h1.exp_data,trans_h1.data_out);
     else
	  $display("DATA MISMATCH!rd_data : %0d : %0d : exp_data",trans_h2.data_out,trans_h1.exp_data);
	 end 
	 endtask
	 
endclass