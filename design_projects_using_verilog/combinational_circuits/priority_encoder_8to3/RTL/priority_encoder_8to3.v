
module priority_encoder_8to3 (a,enable,z);

 //Port declaraion
  input enable;
  input [7:0] a;
  output reg[2:0] z;

 //Implementation
  always @(enable,a)
   begin 
	if (enable==1)
    begin
     if (a[7]==1) z = 3'b111;
     else if (a[6]==1) z=3'b110;
     else if (a[5]==1) z=3'b101;
     else if (a[4]==1) z=3'b100;
     else if (a[3]==1) z=3'b011;
     else if (a[2]==1) z=3'b010;
     else if (a[1]==1) z=3'b001;
     else 
     z = 3'b000;
    end
    else z = 3'bzzz;  
  end
endmodule
