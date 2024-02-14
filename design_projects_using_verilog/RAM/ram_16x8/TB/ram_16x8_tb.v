
`define ADDR_WIDTH 16
`define DATA_WIDTH 8

module ram_tb();

 reg clk,rst;

//Write signals
 reg wr_enable;
 reg [(`ADDR_WIDTH/4)-1:0] wr_addr;
 reg [`DATA_WIDTH-1:0] wr_data;

//Read signals
 reg rd_enable;
 reg [(`ADDR_WIDTH/4)-1:0] rd_addr;
 wire [`DATA_WIDTH-1:0] rd_data;

//Instantiation
ram DUT (clk,rst,wr_enable,wr_addr,wr_data,rd_enable,rd_addr,rd_data);

//Reference model
  reg [`DATA_WIDTH-1:0] rm [0:`ADDR_WIDTH-1];
  reg [`DATA_WIDTH-1:0] exp_data;
  parameter CYCLE = 10;

//Clock generator
  initial begin
   clk = 1'b0;
   forever
    #(CYCLE/2) clk = ~clk;
   end

//Reset task
 task reset();
  begin 
   @(negedge clk);
   rst = 1'b1;
   @(negedge clk);
   rst = 1'b0;
  end
 endtask

//task for write in ram
 task write (input [(`ADDR_WIDTH/4)-1:0] write_addr, input [`DATA_WIDTH-1:0] write_data);
 begin
  @(negedge clk);
    wr_enable = 1'b1;
    wr_addr = write_addr;
    wr_data = write_data;
 end
 endtask

//Task for reading from ram
 task read(input [(`ADDR_WIDTH/4)-1:0] read_addr);
 begin
  @(negedge clk);
    rd_enable = 1'b1;
    rd_addr = read_addr;
 end
 endtask

//Reset check
task reset_check();
 begin
 @(negedge clk)
 rst = 1'b1;
 wr_enable = 1'b1;
 wr_addr = 4'd10;
 wr_data = 8'd23;
 @(negedge clk)
 rd_enable = 1'b1;
 rd_addr = 4'd10;
 @(posedge clk)
 if (rd_data == 0)
    $display("RESET IS WORKING FINE!");
  else
    $display("OOPS, RESET IS NOT WORKING PROPERLY !");
 end
endtask

//Reference model logic
initial begin
forever
  @(posedge clk) begin
  if (rd_enable)
    exp_data = rm[rd_addr];
  if (wr_enable)
    rm[wr_addr] = wr_data;
   end
  end

always@(posedge clk)
 if (rd_data !== 0 && rd_data !== 8'dx) begin
   if (rd_data === exp_data)
      $display("SUCCESS! RD_data = %d : %d = exp_data", rd_data, exp_data);
   else
      $display("DATA MISMATCH! RD_data = %d : %d = exp_data", rd_data, exp_data);
end

initial begin
   reset_check();
   reset;
 //continuous write
   repeat(20)
   write({$random},{$random});
   wr_enable = 1'b0;
 //continuous read
   repeat(20)
   read({$random});
   rd_enable = 1'b0;
 //simultaneous read-write
 /* fork
    begin
     repeat(20)
     write({$random},{$random});
    end
    begin
     repeat(20)
     read({$random});
    end
  join
    wr_enable = 1'b0;
    rd_enable = 1'b0;
    #100 $finish;
 end
*/
end
endmodule
