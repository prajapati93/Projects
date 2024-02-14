module sync_fifo_tb();

//Variable declarations
reg clk,wr_en,rd_en;
reg [7:0] wr_data;
wire fifo_full,fifo_empty;
wire [7:0] rd_data;

parameter CYCLE = 10;

//Instantiation
sync_fifo DUT (clk, wr_en, rd_en, wr_data, rd_data, fifo_full, fifo_empty);

//Clock generator
initial
clk = 0;
always #(CYCLE/2) clk = ~clk;

//Stimulus
initial begin
  wr_en = 0;
  rd_en = 0;
  wr_data = 0;
  #5;
  
  //write data to FIFO
  wr_data = 5;
  wr_en = 1;
  #10;
  wr_data = 10;
  #10;
  wr_data = 20;
  #10;
  wr_data = 30;
  #10;
  wr_en = 0;
  
  //read data from FIFO
  rd_en = 1;
  #10;
  rd_en = 0;
  #10;
  rd_en = 1;
  #10;
  rd_en = 0;
  #10;
  
  //write data to FIFO
  wr_data = 35;
  wr_en = 1;
  #10;
  wr_data = 40;
  #10;
  wr_data = 50;
  #10;
  wr_data = 60;
  #10;
  wr_en = 0;
  
  //read data from FIFO
  rd_en = 1;
  #10;
  rd_en = 0;
  #10;
  rd_en = 1;
  #10;
  rd_en = 0;
  #10 $finish;
  end
endmodule
