RTL = ../RTL/fifo1.sv
INF = ../ENV/fifo_if.sv
PKG = ../TEST/fifo_pkg.sv
TP = ../TOP/fifo_top.sv

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