class low_range_write_test extends afifo_trans;

	//constraint for low range data
    constraint LOW_RANGE {din < 100;}
    constraint WR_ENB  {wr_en == 1; rd_en==1; clear_n==1;}
    
endclass
