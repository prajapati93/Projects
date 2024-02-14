
module dff_top ();

wire d;

dff DUT (.d(d),.rst(rst),.clk(clk),.q(q));
dff_tb TB (.d(d),.rst(rst),.clk(clk),.q(q));

endmodule
