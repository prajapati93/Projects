////////////////////////////////////////////////
// RAM Verification in SV
// File description: Transaction class for the kind of operation called.
//                   And to generate randomized constraint.
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////


`ifndef RAM_TRANS_SV
`define RAM_TRANS_SV

typedef enum bit [1:0] {IDLE,READ,WRITE,SIM_RW} trans_kind;

class ram_trans;

  rand trans_kind trans_kind_e;
  
  rand bit rst;
  static int wr_cnt, rd_cnt;
   
  //write_signals
  rand bit wr_enb;
  randc bit [3:0] wr_addr;
  rand bit [7:0] wr_data;
  

  //read_signals
  rand bit rd_enb;
  randc bit [3:0] rd_addr;
  bit [7:0]rd_data;
  
  //exp_data
  bit [7:0] exp_data;
   
   //default constraint
  //constraint RST {soft rst == 1'b0;}
  //constraint ENB { trans_kind_e >= 1'b1;}
  constraint ENB {soft wr_enb==1'b1; soft rd_enb==1'b1;}
  
  //add static variables to record no. of write and read transaction
  function cnt();
    if((trans_kind_e == WRITE) || (trans_kind_e == SIM_RW))
	  wr_cnt++;
	if((trans_kind_e == READ) || (trans_kind_e == SIM_RW))
	  wr_cnt++;  
  endfunction
  
  /* //add custom print/display method to print transaction attributes
  function void write_display();
  $display("|WR_ADDR:%0d, WR_ENB:%0d, WR_DATA:%0d|", wr_addr,wr_enb,wr_data);
  endfunction
  
  function void read_display();
  $display("|RD_ADDR:%0d, RD_ENB:%0d, RD_DATA:%0d|", rd_addr,rd_enb,rd_data);
  endfunction
  
  function void wd_display();
  //$write($realtime);
  $display("~~~~~~~~~~~~WR_DRV~~~~~~~~~~~~");
  write_display();
  endfunction
  
  function void wm_display();
  //$write($realtime);
  $display("~~~~~~~~~~~~~WR_MON~~~~~~~~~~~~~");
  write_display();
  endfunction
  
  function void rd_display();
  //$write($realtime);
  $display("~~~~~~~~~~~~RD_DRV~~~~~~~~~~~~");
  read_display();
  endfunction
  
  function void rm_display();
  //$write($realtime);
  $display("~~~~~~~~~~~~~RD_MON~~~~~~~~~~~~~");
  read_display();
  endfunction */
  
  task print();
    $display("|   Name    |     Data     |   Time   |" );
    $display("------------------------------------------");
    $display("|   Rst     |   %6d     |   %4t   |",this.rst,$time);
    $display("|   Enb     |   %6s     |   %4t   |",this.trans_kind_e,$time);
    $display("| Wr_Addr   |   %6d     |   %4t   |",this.wr_addr,$time);
    $display("| Wr_Data   |   %6d     |   %4t   |",this.wr_data,$time);
    $display("| Rd_Addr   |   %6d     |   %4t   |",this.rd_addr,$time);
    $display("| Rd_Data   |   %6d     |   %4t   |",this.rd_data,$time);
    $display("------------------------------------------");
  endtask
  
  task cnt_print();
    $info("wr_cnt= %0d, rd_cnt = %0d",wr_cnt,rd_cnt);
  endtask
  
endclass

`endif
