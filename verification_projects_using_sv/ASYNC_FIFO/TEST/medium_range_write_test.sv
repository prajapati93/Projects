
class medium_range_write_test extends afifo_trans;

	//constraint for low range data
    constraint MID_RANGE {din > 100; din < 200;}
    constraint WR_ENB  {wr_en == 1; rd_en==1; clear_n==1;}

endclass