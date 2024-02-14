
module half_adder_tb();

  reg x, y;
  wire sum,carry;
  
  //Design instantion
  half_adder DUT (.a(x),.b(y),.sum(sum),.carry(carry));
  
  initial begin
        x = 0;	y = 0;
	#10
	x = 0;  y = 1;
	#10
	x = 1;  y = 0;
	#10
	x = 1;  y = 1;
	#10 $finish;
	end
    
  
 endmodule
