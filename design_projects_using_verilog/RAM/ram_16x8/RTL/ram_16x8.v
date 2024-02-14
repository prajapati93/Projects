 
//RAM 16x8
`define ADDR_WIDTH 4
`define DEPTH 16
`define DATA_WIDTH 8

module ram (clk,
            rst,
            wr_enable,
            wr_addr,
            wr_data,
            rd_enable,
            rd_addr,
            rd_data);

//Port declaration
input clk, rst;

  //Write signals
  input wr_enable;
  input [`ADDR_WIDTH-1:0] wr_addr;
  input [`DATA_WIDTH-1:0] wr_data;

  //Read signals
  input rd_enable;
  input [`ADDR_WIDTH-1:0] rd_addr;
  output reg [`DATA_WIDTH-1:0] rd_data;

  //Internal memory
  reg [`DATA_WIDTH-1:0] ram [0:`DEPTH-1];
  reg [`ADDR_WIDTH-1:0] i;

//Implementation
  always @(posedge clk)
   if (rst) begin
    rd_data <= `DATA_WIDTH'd0;
    for (i=0; i<`DEPTH; i=i+1) //Memory instantiation
    ram[i] <= `DATA_WIDTH'd0;
  end
  else begin
  if (wr_enable)
   ram[wr_addr] <= wr_data; //Write
  if (rd_enable)
   rd_data <= ram[rd_addr]; //Read
  end
endmodule
