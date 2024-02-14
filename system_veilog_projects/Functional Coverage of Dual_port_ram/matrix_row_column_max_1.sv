//parameter data = 4;
module array();
class abc;
parameter WIDTH = 8;
rand bit [(WIDTH-1):0] x [][];


constraint ar {foreach(x[i,j]) {   
                   if (j==0 && i>0) {    //for first column (nth element is greater than (n-1)' element in first column) 
                     x[i][j] > x[i-1][j];
                   }
                   else if(i!=0 || j != 0){   //all rows except very first element[0][0]
                     x[i][j] > x[i][j-1];     //nth element is greater than (n-1)' element in a row
                   }   //else if
               }  //foreach
              }               
              
  constraint SIZE {x.size() == 5 ; foreach(x[i]) x[i].size() == 5;}
              
  function void post_randomize();
    foreach(x[i]) begin
      $write("|");
      for(int j=0;j<x[i].size();j++)
        $write("  %3d",x[i][j]);
      $display("|");
    end
  endfunction
endclass

abc h1 = new();

initial begin
 h1.randomize();
 //$display("\n h1.x =%p",h1.x);
 #10 $finish;
end

endmodule 
 