////////////////////////////////////////////////
// RAM Verification in SV
// File description: Compare the expected data with read monitor data.
//      It gives error messages if there is any error in DUT.                        
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

`ifndef RAM_SB_SV
`define RAM_SB_SV

//description
class ram_sb;

 bit [7:0]act_trans_q[$];
 bit [7:0]exp_trans_q[$];
 
 bit [7:0]act_data,exp_data;
 
 ram_trans act_trans, exp_trans;
 
 mailbox #(ram_trans) rf_sb;
 mailbox #(ram_trans) rm_sb;
 
 //description
 function new(mailbox #(ram_trans) rf_sb,
              mailbox #(ram_trans) rm_sb);
   this.rf_sb = rf_sb;
   this.rm_sb  = rm_sb;
 endfunction
 
 //Declaring covergroup and bins
 covergroup cvg;
    Write_Addr : coverpoint exp_trans.wr_addr {
	    bins WRA0[] = {[0:15]};
		}
	Write_Data : coverpoint exp_trans.wr_data {
        bins WRD0 = {[0:50]};
        bins WRD1 = {[51:100]};
        bins WRD2 = {[101:200]};
		bins WRD3 = {[201:255]};
		}
	Read_Addr : coverpoint act_trans.rd_addr {
	    bins RDA0 = {[0:3]};
		bins RDA1 = {[4:7]};
		bins RDA2 = {[8:11]};
		bins RDA3 = {[12:15]};
		}
	Read_Data : coverpoint exp_trans.rd_data {
	    bins RDD0 = {[0:50]};
		bins RDD1 = {[51:100]};
		bins RDD2 = {[101:200]};
		bins RDD3 = {[201:255]};
		}
	
	Write_enb : coverpoint exp_trans.wr_enb {
	    bins WR_ENB1 = (0=>1);
		bins WR_ENB2 = (1=>0);
		}
	
	Read_enb : coverpoint act_trans.rd_enb {
	    bins RD_ENB1 = (0=>1);
		bins RD_ENB2 = (1=>0);
		}
    
	endgroup
	
    cvg = new();
    //cvg = cvg_h new();	
 
 //description
 task run();
 forever begin
// repeat(15) begin
	 act_trans = new;
	 exp_trans = new;
	 rm_sb.get(act_trans);
	 rf_sb.get(exp_trans);
	 display();
	 check_data(act_trans,exp_trans);
   end
 endtask	
 
 //Task to check and display comapared data
 task check_data(ram_trans act_trans, ram_trans exp_trans);
    fork
	    wait(act_trans_q.size != 0);
		wait(exp_trans_q.size != 0);
	join
	
	act_data = act_trans_q.pop_front();
	exp_data = exp_trans_q.pop_front();
	begin
	if(act_trans.rd_data == exp_trans.exp_data)
	    $display("||\tPASS ACT: %0d & EXP: %0d\t||", act_trans.rd_data,exp_trans.exp_data);
	else
	    $display("||\tFAIL ACT: %0d & EXP: %0d\t||", act_trans.rd_data,exp_trans.exp_data);
    end
 endtask
 
 function void display();
  $display("~~~~~~~~~~SCOREBOARD~~~~~~~~~~~~");
  $display("||\tEXP_DATA: %0d\t\t||",exp_trans.exp_data);
 endfunction
 
 
endclass :ram_sb

`endif