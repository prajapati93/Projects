

`define BUF_WIDTH 3    // BUF_SIZE = 16 -> BUF_WIDTH = 4, no. of bits to be used in pointer
`define BUF_SIZE ( 1<<`BUF_WIDTH )

module fifo( clk, rst, data_in, data_out, wr_enb, rd_enb, empty, full, count );

input                 rst, clk, wr_enb, rd_enb;   
// reset, system clock, write enable and read enable.
input [7:0]           data_in;                   
// data input to be pushed to buffer
output[7:0]           data_out;                  
// port to output the data using pop.
output                empty, full;      
// buffer empty and full indication 
output[`BUF_WIDTH :0] count;             
// number of data pushed in to buffer   

reg[7:0]              data_out;
reg                   empty, full;
reg[`BUF_WIDTH :0]    count;
reg[`BUF_WIDTH -1:0]  rd_ptr, wr_ptr;           // pointer to read and write addresses  
reg[7:0]              ram[`BUF_SIZE -1 : 0]; //  

always @(count)
begin
   empty = (count==0);   // Checking for whether buffer is empty or not
   full = (count== `BUF_SIZE);  //Checking for whether buffer is full or not

end

//Setting FIFO count value for different situations of read and write operations.
always @(posedge clk or posedge rst)
begin
   if( rst )
       count <= 0; // Reset the count of FIFO

   else if( (!full && wr_enb) && ( !empty && rd_enb ) )  //When doing read and write operation simultaneously
       count <= count; // At this state, count value will remain same.

   else if( !full && wr_enb ) // When doing only write operation
       count <= count + 1;

   else if( !empty && rd_enb ) //When doing only read operation
       count <= count - 1;

   else
      count <= count; // When doing nothing.
end

always @( posedge clk or posedge rst)
begin
   if( rst )
      data_out <= 0; //On reset output of buffer is all 0.
   else
   begin
      if( rd_enb && !empty )
         data_out <= ram[rd_ptr]; //Reading the 8 bit data from buffer location indicated by read pointer

      else
         data_out <= data_out; 

   end
end

always @(posedge clk)
begin
   if( wr_enb && !full )
      ram[ wr_ptr ] <= data_in; //Writing 8 bit data input to buffer location indicated by write pointer

   else
      ram[ wr_ptr ] <= ram[ wr_ptr ];
end

always@(posedge clk or posedge rst)
begin
   if( rst )
   begin
      wr_ptr <= 0; // Initializing write pointer
      rd_ptr <= 0; //Initializing read pointer
   end
   else
   begin
      if( !full && wr_enb )    
wr_ptr <= wr_ptr + 1; // On write operation, Write pointer points to next location
      else  
wr_ptr <= wr_ptr;

      if( !empty && rd_enb )   
rd_ptr <= rd_ptr + 1; // On read operation, read pointer points to next location to be read
      else 
rd_ptr <= rd_ptr;
   end

end
endmodule
