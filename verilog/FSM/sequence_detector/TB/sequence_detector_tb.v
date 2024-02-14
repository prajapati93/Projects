`timescale 1ns/1ps

module sequence_detector_tb();

//Variable declaration
reg sequence, clk,rstn;
wire out;

//Instantiation
sequence_detector DUT (sequence,clk,rstn,out);

//Clock generator
initial begin
clk = 1'b0;
forever #5 clk = ~clk;
end

//Stimulus
initial begin
sequence = 1'b0;
rstn = 1'b0;
#30;
rstn = 1'b1;
#40;
sequence = 1'b0; #10 sequence = 1'b1; #10 sequence = 1'b0; #10 sequence = 1'b1;
#10 sequence = 1'b1; #10 sequence = 1'b0; #10 sequence = 1'b1; #10 sequence = 1'b0;
#10 sequence = 1'b0; #10 sequence = 1'b1; #10 sequence = 1'b1; #10 sequence = 1'b0;
#10 sequence = 1'b1; #10 sequence = 1'b0; #10 sequence = 1'b0; #10 sequence = 1'b1;
#10 sequence = 1'b0; #10 sequence = 1'b0; #10 sequence = 1'b1; #10 sequence = 1'b1;
#10 sequence = 1'b1; #10 sequence = 1'b1; #10 sequence = 1'b0; #10 sequence = 1'b1;
#10 sequence = 1'b1; #10 sequence = 1'b1; #10 sequence = 1'b0; #10 sequence = 1'b0;
#100;
$finish;

end
endmodule


