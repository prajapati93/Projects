
module priority_encoder_8to3_tb ();

	reg [7:0] a;
 	reg enable;
	wire [2:0] z;
 
 //instantiation
 priority_encoder_8to3 DUT (.a(a),.enable(enable),.z(z));
 
 initial begin
 enable = 1; a = 8'b1000_0000;
 #10
 enable = 1; a = 8'b0100_0000;
 #10
 enable = 1; a = 8'b0010_0000;
 10
 enable = 1; a = 8'b0001_0000;
 #10
 enable = 1; a = 8'b0000_1000;
 #10
 enable = 1; a = 8'b0000_0100;
 #10 
 enable = 1; a = 8'b0000_0010;
 #10
 enable = 1; a = 8'b0000_0000;
 #10
 enable = 0; a = 8'bxxxx_xxxx;
 #10 $finish;
 end
endmodule
