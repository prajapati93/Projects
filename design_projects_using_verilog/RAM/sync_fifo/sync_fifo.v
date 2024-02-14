module sync_fifo (clk, wr_en, rd_en, wr_data, rd_data, fifo_full, fifo_empty);

//Port declaration
input clk, wr_en, rd_en;
input [7:0] wr_data;
output [7:0] rd_data;
output fifo_empty,fifo_full;

//Parameter
parameter DEPTH = 16;

//Local variables
reg [7:0] mem [0:DEPTH-1];
reg [3:0] wr_ptr, rd_ptr;
wire [3:0] count, wr_ptr_n, rd_ptr_n;

//Logic
assign count = wr_ptr - rd_ptr;
assign wr_ptr_n = (wr_en && ~fifo_full) ? (wr_ptr + 1) : wr_ptr;
assign rd_ptr_n = (rd_en && ~fifo_empty) ? (rd_ptr + 1) : rd_ptr;
assign rd_data = mem[rd_ptr];
assign full = (count==DEPTH);
assign empty = (count==0);

//Implementation
always @(posedge clk)
   begin
   wr_ptr <= wr_ptr_n;
   rd_ptr <= rd_ptr_n;
     if (wr_en && ~fifo_full)
	   begin
	   mem[wr_ptr]<=wr_data;
	   end
   end

endmodule