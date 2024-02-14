////////////////////////////////////////////////
// RAM Verification in SV
// File description: Reference model predicts the data.                   
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

class ram_rf;

  ram_trans trans_h1,trans_h2,exp_h; 
  
  //Internal RAM
  bit [7:0]ram_exp[];
  
  //mailbox
   mailbox #(ram_trans) wm_rf;
   mailbox #(ram_trans) rm_rf;
   mailbox #(ram_trans) rf_sb;
   
   function new (mailbox #(ram_trans) wm_rf,
                 mailbox #(ram_trans) rm_rf,
                 mailbox #(ram_trans) rf_sb);
	this.wm_rf = wm_rf;
	this.rm_rf = rm_rf;
	this.rf_sb = rf_sb;
  endfunction
  
  
  task run();
     ram_exp = new[16];
   forever begin
   //repeat(50) begin
   //trans_h1 = new;
   //trans_h2 = new;
	wm_rf.get(trans_h1);
	rm_rf.get(trans_h2);
	exp_h = new trans_h2; //Shallow copy
	predict_exp_rd_data(trans_h1,trans_h2);
	display();
	rf_sb.put(exp_h);
   end
  endtask
    
  //To predict data from read & write monitor
 task predict_exp_rd_data(ram_trans wr_trans_h, rd_trans_h);
    if(rd_trans_h.rd_enb)
       trans_h2.exp_data = ram_exp[rd_trans_h.rd_addr];
	if(wr_trans_h.wr_enb)
	   ram_exp[wr_trans_h.wr_addr] = wr_trans_h.wr_data;
 endtask
 
 function void display();
   $display("~~~~~~~~REFERENCE MODEL~~~~~~~~~");
   $write("||WRITE ADDR: %0d||WRITE DATA: %0d||\n", trans_h1.wr_addr, trans_h1.wr_data);
   $write("||READ  ADDR: %0d||EXP   DATA: %0d||\n", trans_h2.rd_addr, trans_h2.exp_data);
 endfunction
   
  
 endclass
	