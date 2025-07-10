RTL = ../RTL/async_fifo.sv
INF = ../ENV/afifo_interface.sv
PKG = ../TEST/afifo_pkg.sv
TP  = ../TOP/afifo_top.sv
TOP_MODULE = top

lib:
	vlib work

cmpl:
	vlog $(INF) $(RTL) $(PKG) $(TP) +incdir+../ENV +incdir+../TEST
	
sim:
	vsim -novopt $(TOP_MODULE) -c -do "run -all; exit"

sim_cov:
	vsim -coverage -vopt $(TOP_MODULE) -c -do "coverage save -onexit -assert -directive -cvg -codeall write_read; run -all; exit" +write_then_read_test

TC1:
	vsim -coverage -vopt $(TOP_MODULE) -c -do "coverage save -onexit -assert -directive -cvg -codeall write_only; run -all; exit" +write_only_test

TC2:
	vsim -coverage -vopt $(TOP_MODULE) -c -do "coverage save -onexit -assert -directive -cvg -codeall read_only; run -all; exit" +read_only_test

TC3:
	vsim -coverage -vopt $(TOP_MODULE) -c -do "coverage save -onexit -assert -directive -cvg -codeall half_write; run -all; exit" +half_write_test

TC4:
	vsim -coverage -vopt $(TOP_MODULE) -c -do "coverage save -onexit -assert -directive -cvg -codeall write_read; run -all; exit" +write_read_test

TC5:
	vsim -coverage -vopt $(TOP_MODULE) -c -do "coverage save -onexit -assert -directive -cvg -codeall write_then_read; run -all; exit" +write_then_read_test

TC6:
	vsim -coverage -vopt $(TOP_MODULE) -c -do "coverage save -onexit -assert -directive -cvg -codeall write_with_reset; run -all; exit" +write_with_reset_test

TC7:
	vsim -coverage -vopt $(TOP_MODULE) -c -do "coverage save -onexit -assert -directive -cvg -codeall high_range_write; run -all; exit" +high_range_write_test
	
TC8:
	vsim -coverage -vopt $(TOP_MODULE) -c -do "coverage save -onexit -assert -directive -cvg -codeall low_range_write; run -all; exit" +low_range_write_test
	
TC9:
	vsim -coverage -vopt $(TOP_MODULE) -c -do "coverage save -onexit -assert -directive -cvg -codeall medium_range_write; run -all; exit" +medium_range_write_test

coverage:
	vcover report -html write_read

cov:
	vcover merge cov_mrg write_only half_write write_read write_then_read write_with_reset high_range_write low_range_write medium_range_write
	vcover report -html cov_mrg

cov1:
	vcover report -html write_read

regress_1: lib cmpl sim_cov cov1

regress: lib cmpl TC1 TC2 TC3 TC4 TC5 TC6 TC7 TC8 TC9 cov
