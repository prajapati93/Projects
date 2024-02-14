
module mux_4x1 (a,b,c,d,sel,out);
 
 //Port declaration 
 input [3:0] a;
 input [3:0] b;
 input [3:0] c;
 input [3:0] d;
 input [1:0] sel;
 output [3:0] out;

 //Implementation#
 
 assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a);

endmodule

