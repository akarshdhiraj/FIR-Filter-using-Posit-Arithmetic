`timescale 1 ms/10 us
`define INP_SIZE 10
`define COEFF_SIZE 10
`define ORDER 24
`define CHANNELS 8
`define BANDS 5
`define SAMPLES 94
module fir_tb;
reg [`INP_SIZE-1 : 0] fir_in;
reg clk; reg rst;
wire [(`INP_SIZE + `COEFF_SIZE) -1 : 0] fir_out ;
localparam clk_period = 8;
reg [INP_SIZE-1:0] fd1 [0:`SAMPLES-1]; 
reg [INP_SIZE-1:0] fd2 [0:`SAMPLES-1]; 
integer i;
fir #(10,10,32) fir_sys0 (system_inp,clk,rst,system_outp); 
always
begin
clk = 1'b1;
#(clk_period/2);
clk = 1'b0;
#(clk_period/2);
end
initial
begin
$readmemb("test_inputs.txt", fd1); 
rst = 1'b1; //reset to initialise the registers
#(clk_period*3);
#(clk_period/2);
rst = 1'b0;
for (i = 0; i < `SAMPLES; i = i + 1)
begin
$display("%b:%d", fd1[i], i);
system_inp <= fd1[i]; 
#(clk_period);
fd2[i] <= fir_out; end
$writememb("hw_outputs.txt", fd2); txt file
#(clk_period);
$stop;
end
endmodule
