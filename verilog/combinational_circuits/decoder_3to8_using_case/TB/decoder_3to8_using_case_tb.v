
module decoder_3to8_using_case_tb();

  wire [7:0] out;
  reg [2:0] a;
  reg en;
  integer i;
  
  decoder_3to8_using_case DUT (a,en,out);
  
  initial begin
  for (i = 0; i < 16; i=i+1)
     begin
     {en,a} = i;
     #100;
     end
   
   end
 
 endmodule

