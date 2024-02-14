RTL = ../RTL/apb_rtl.sv
INF = ../ENV/apb_if.sv
PKG = ../TEST/apb_pkg.sv
TP = ../TOP/apb_top.sv

lib:
	vlib work

comp:
	vlog $(INF) $(RTL) $(PKG) $(TP) +incdir+../ENV +incdir+../TEST

sim:
	vsim -novopt top -c -do "run -all;exit"
run: comp sim
simw:
	vsim -novopt top
runw: comp simw