module fir #(parameter INP_SIZE = 10,
parameter COEFF_SIZE = 10,
parameter ORDER = 32)
(input [INP_SIZE-1 : 0] fir_in,
input fir_clk,
input fir_rst,
output [INP_SIZE - 1 : 0] fir_out);
reg [INP_SIZE-1 : 0] inp_reg;
reg [INP_SIZE + COEFF_SIZE - 1 : 0] outp_reg;
wire input [0 : COEFF_SIZE*((ORDER/2)+1) - 1] fir_coeff_inp;
reg [COEFF_SIZE-1 : 0] fir_coeff [0 : (ORDER/2)];
wire [(INP_SIZE) - 1 : 0] mult_out [0 : ORDER/2];
wire [(INP_SIZE) - 1 : 0] reg_out [0 : ORDER - 1];
wire [(INP_SIZE) - 1 : 0] add_out [0 : ORDER - 1];
integer j;
always@(posedge fir_clk) begin
if(fir_rst == 1'b1) begin
inp_reg <= 0;
end
else begin
inp_reg <= fir_in;
end
end
assign fir_coeff_inp = 
{10'd975,10'd961,10'd944,10'd932,10'd923,10'd916,10'd912,10'd911,10'd915,10'd927,10'd56
,10'd107,10'd123,10'd137,10'd149,10'd157,10'd159};
always@(*) begin
for (j=0; j<= ORDER/2; j=j+1) begin
fir_coeff[j] <= fir_coeff_inp[(j*COEFF_SIZE) +: COEFF_SIZE];
end
end
genvar i;
generate
for (i = 0; i<= ORDER/2; i = i + 1) begin : gen0
#(.MULT_INP1_SIZE(INP_SIZE), .MULT_INP2_SIZE(COEFF_SIZE)) m0
multiplier m1(.a(fir_in), .b(fir_coeff[i]), .p(mult_out[i]));
end
endgenerate
generate
for (i = 0; i<= (ORDER/2) - 1; i = i + 1) begin : gen1
#(.ADD_INP1_SIZE(INP_SIZE + COEFF_SIZE), .ADD_INP2_SIZE(INP_SIZE + 
COEFF_SIZE)) a0
adder a1(.a(reg_out[i]), .b(mult_out[i+1]), .outp(add_out[i]));
end
endgenerate
generate
for (i = ORDER/2; i <= (ORDER - 1); i= i + 1) begin : gen2
#(.ADD_INP1_SIZE(INP_SIZE + COEFF_SIZE), .ADD_INP2_SIZE(INP_SIZE + 
COEFF_SIZE)) a1
adder a2(.a(reg_out[i]), .b(mult_out[ORDER-1-i]), .outp(add_out[i]));
end
endgenerate
intermediate_regs #(.REG_INP_SIZE(INP_SIZE + COEFF_SIZE))
ir0 (.reg_in(mult_out[0]), .clk(fir_clk), .rst(fir_rst),
.reg_out(reg_out[0]));
generate
for (i = 1; i <= (ORDER - 1); i = i + 1) begin : gen3
intermediate_regs #(.REG_INP_SIZE(INP_SIZE + COEFF_SIZE))
ir0 (.reg_in(add_out[i-1]), .clk(fir_clk),
.rst(fir_rst),
.reg_out(reg_out[i]));
end
endgenerate
always@(posedge fir_clk) begin
if(fir_rst == 1'b1) begin
outp_reg <= 0;
end
else begin
outp_reg <= add_out[ORDER-1];
end
end
assign fir_out = outp_reg;
endmodule
