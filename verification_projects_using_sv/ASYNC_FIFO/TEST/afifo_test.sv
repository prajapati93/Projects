`ifndef AFIFO_TEST
`define AFIFO_TEST

import afifo_pkg::*;

class afifo_test;

    //Environment and generator instances
	afifo_env env_h;
	afifo_trans t_h;
	afifo_gen gen_h;
	
	//Testcases instances
	half_write_test         half_write_h;
	high_range_write_test   high_range_write_h;
	medium_range_write_test medium_range_write_h;
	low_range_write_test    low_range_write_h;
	read_only_test          read_only_h;
	write_only_test         write_only_h;
	write_read_test         write_read_h;
	write_then_read_test    write_then_read_h;
	write_with_reset_test   write_with_reset_h;
	
	
	//Virtual interface for driver and monitor
    virtual afifo_interface.WR_DRV_MP d_wvif;
    virtual afifo_interface.RD_DRV_MP d_rvif;

    virtual afifo_interface.WR_MON_MP m_wvif;
    virtual afifo_interface.RD_MON_MP m_rvif;
	
	function new (virtual afifo_interface.WR_DRV_MP d_wvif,
				  virtual afifo_interface.RD_DRV_MP d_rvif,
				  virtual afifo_interface.WR_MON_MP m_wvif,
				  virtual afifo_interface.RD_MON_MP m_rvif);
		this.d_wvif   = d_wvif;
		this.d_rvif   = d_rvif;
		this.m_wvif   = m_wvif;
		this.m_rvif   = m_rvif;
    endfunction
	
	//Method for build and run
	task build_and_run();

      env_h = new(d_wvif,d_rvif,m_wvif,m_rvif);
      env_h.build();

		//Test Cases 
		if($test$plusargs("write_only_test")) begin
		  write_only_h = new(env_h.gen_drv);
		  iteration = 25;
		  env_h.gen_h = write_only_h;
		end 

		if($test$plusargs("half_write_test")) begin
		  half_write_h = new(env_h.gen_drv);
		  iteration = 10;
		  env_h.gen_h = half_write_h;
		end

		if($test$plusargs("write_read_test")) begin
		  write_read_h = new(env_h.gen_drv);
		  iteration = 25;
		  env_h.gen_h = write_read_h;
		end

		if($test$plusargs("write_then_read_test")) begin
		  write_then_read_h = new(env_h.gen_drv);
		  iteration = 25;
		  env_h.gen_h = write_then_read_h;
		end

		if($test$plusargs("write_with_reset_test")) begin
		  write_with_reset_h = new(env_h.gen_drv);
		  iteration = 10;
		  env_h.gen_h = write_with_reset_h;
		end
		
		/* if($test$plusargs("read_only_test")) begin
		  read_only_h = new(env_h.gen_drv);
		  iteration = 10;
		  env_h.gen_h = read_only_h;
		end
		
		if($test$plusargs("high_range_write_test")) begin
		  high_range_write_h = new(env_h.gen_drv);
		  iteration = 25;
		  env_h.gen_h = high_range_write_h;
		end
		
		if($test$plusargs("low_range_write_test")) begin
		  low_range_write_h = new(env_h.gen_drv);
		  iteration = 25;
		  env_h.gen_h = low_range_write_h;
		end
		
		if($test$plusargs("medium_range_write_test")) begin
		  medium_range_write_h = new(env_h.gen_drv);
		  iteration = 25;
		  env_h.gen_h = medium_range_write_h;
		end */
		
		env_h.run();
	endtask

endclass: afifo_test


`endif