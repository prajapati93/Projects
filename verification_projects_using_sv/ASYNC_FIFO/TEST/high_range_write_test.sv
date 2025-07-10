class high_range_write_test extends afifo_trans;

	//constraint for high range data
    constraint HIGH_RANGE {din > 200;}
    constraint WR_ENB  {wr_en == 1; rd_en==1; clear_n==1;}

endclass