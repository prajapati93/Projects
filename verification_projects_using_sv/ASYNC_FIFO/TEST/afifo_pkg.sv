package afifo_pkg;
	
	int iteration = 25;
	
    `include "afifo_defines.sv"
	`include "afifo_trans.sv"
	`include "afifo_gen.sv"
	`include "afifo_drv.sv"
	`include "afifo_mon.sv"
	`include "afifo_rf.sv"
	//`include "afifo_coverage.sv"
	`include "afifo_sb.sv"
	`include "afifo_env.sv"
	
	`include "write_only_test.sv"
	`include "read_only_test.sv"
	`include "half_write_test.sv"
	`include "high_range_write_test.sv"
	`include "low_range_write_test.sv"
	`include "medium_range_write_test.sv"
	`include "write_read_test.sv"
	`include "write_then_read_test.sv"
	`include "write_with_reset_test.sv"
	
	`include "afifo_test.sv"


endpackage