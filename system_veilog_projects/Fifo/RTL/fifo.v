////////////////////////////////////////////////
// FIFO Verification in SV
// File description: RTL code for FIFO
// Author Name: Mehul Prajapati
// Version: 1.0
/////////////////////////////////////////////////

module fifo (data_in,data_out,clk,rst,rd_enb,wr_enb,empty,full,count);

//Port Declaration
input clk,rst,rd_enb,wr_enb;
input [7:0] data_in;

output empty,full;
output reg [3:0] count;
output reg [7:0] data_out;

reg [7:0] ram [0:7];
reg [2:0] rd_ptr, wr_ptr;
assign empty = (count == 0);
assign full  = (count == 8);

//Write data to fifo memory
always@(posedge clk)
	if (rst)
	    data_in <= 0;
	else begin
		if (wr_enb && !full)
			ram[wr_ptr] <= data_in;
		else if (wr_enb && rd_enb)
			ram[wr_ptr] <= data_in;
	end

//Read data from fifo memory
always@(posedge clk)
	begin
		if (rd_enb && !empty)
			data_out <= ram[rd_ptr];
		else if (rd_enb && wr_ptr)
			data_out <= ram[rd_ptr];
	end

//Read & Write Pointers logic
always@(posedge clk)
	begin
		if (rst)
			begin
			wr_ptr <= 0;
			rd_ptr <= 0;
			wr_enb <= 0;
			rd_enb <= 0;
			end
		else
			begin
			wr_ptr <= ((wr_enb && !full) || (wr_enb && rd_enb)) ? wr_ptr+1 : wr_ptr;
			rd_ptr <= ((rd_enb && !empty) || (wr_enb && rd_enb)) ? rd_ptr+1 : rd_ptr;
			end
	end

//Logic Implementation

always@(posedge clk)
	begin
		if(rst)
		count <= 0;
		else begin
			case ({wr_enb,rd_enb})
				2'b00 : count <= count;
				2'b01 : count <= (count == 0) ? 0 : count-1;
				2'b10 : count <= (count == 8) ? 8 : count+1;
				2'b11 : count <= count;
				default: count <= count;
			endcase
		end
	end
	
endmodule