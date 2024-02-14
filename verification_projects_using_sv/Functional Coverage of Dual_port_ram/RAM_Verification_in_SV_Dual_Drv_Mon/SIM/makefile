RTL = ../RTL/ram_16x8.v
INF = ../ENV/ram_if.sv
PKG = ../TEST/ram_pkg.sv
TP = ../TOP/ram_top.sv
TOP_MODULE = ram_top

lib:
	vlib work
comp:
	vlog $(RTL) $(PKG) $(TP) +incdir+..\ENV +incidr+..\TEST 
covcomp:
	vlog +cover +acc
simul:
	vsim -novopt ram_tb_top -c -do "run -all;exit" 	
run_cmd:
	vsim -coverage -vopt $(TOP_MODULE) -c -do "coverage save onexit -directive -cvg -codeall ram_cov; run -all; exit"
cov:
	vcover report -html ram_cov
wave:
	add wave sim:/ram_tb_top/inf/*	
	add wave sim:/ram_tb_top/DUT/*
	run -all