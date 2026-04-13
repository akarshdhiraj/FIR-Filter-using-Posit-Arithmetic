`timescale 10 us/1 us
`define INP_SIZE 10
module posit_multiplier_tb;
reg [`INP_SIZE-1:0] inp1,inp2;
wire [`INP_SIZE-1:0] product;
posit_multiplier mult1(.inp1(inp1),.inp2(inp2),.product(product));
initial begin
inp1 = 10'b1110011001;
inp2 = 10'b0001100101;
#10
inp1 = 10'b1110011001;
inp2 = 10'b0000000000;
#10
inp1 = 10'b0011101101;
inp2 = 10'b1111111001;
#10
inp1 = 10'b0001110010;
inp2 = 10'b0011011000;
#10
inp1 = 10'b1110000010;
inp2 = 10'b0011000111;
#10
inp1 = 10'b0000011110;
inp2 = 10'b0010101011;
#10
inp1 = 10'b1111000011;
inp2 = 10'b0001100100;
#10
$stop;
end
endmodule
