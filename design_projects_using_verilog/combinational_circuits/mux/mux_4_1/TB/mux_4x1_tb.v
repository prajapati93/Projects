
module mux_4x1_tb();
 
 reg [3:0] a,b,c,d;
 reg [1:0] sel;
 wire out;

  //Instantiation
  mux_4x1 DUT (.a(a),.b(b),.c(c),.d(d),.sel(sel),.out(out));

  initial begin
  a = 4'b0001; b = 4'b0000; c = 4'b0000; d = 4'b0000; sel = 2'b01;
  #10
  a = 4'b0000; b = 4'b0010; c = 4'b0000; d = 4'b0000; sel = 2'b00;
  #10
  a = 4'b0000; b = 4'b0000; c = 4'b0100; d = 4'b0000; sel = 2'b01;
  #10
  a = 4'b0000; b = 4'b0000; c = 4'b0000; d = 4'b1000; sel = 2'b00;
  #10 $finish;
  end

endmodule
