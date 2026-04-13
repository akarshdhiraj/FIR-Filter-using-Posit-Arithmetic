module posit_multiplier #(parameter INP_SIZE = 10,
parameter ES = 2)
(
input [INP_SIZE-1:0] inp1,inp2,
output [INP_SIZE-1:0] product; 
wire [INP_SIZE-1:0] abs_inp1, abs_inp2;
reg [3:0] k_val1, k_val2; wire [2:0] regime_end_index1; 
wire [2:0] regime_end_index2; wire [ES-1:0] exp1;
wire [ES-1:0] exp2;
wire [INP_SIZE-1:0] exp_extractor1wire [INP_SIZE-1:0] exp_extractor2;
wire [INP_SIZE-1:0] exp_intermediate1; wire [INP_SIZE-1:0] exp_intermediate2;
wire [INP_SIZE-1:0] frac1;
wire [INP_SIZE-1:0] frac2;
wire [INP_SIZE-1:0] frac1_frac;
wire [INP_SIZE-1:0] frac2_frac;
wire [INP_SIZE-1:0] frac1_1_append;
wire [INP_SIZE-1:0] frac2_1_append;
wire [INP_SIZE-1:0] frac_extractor1; wire [INP_SIZE-1:0] frac_extractor2;
wire signed [4:0] k_val1_2comp; 
wire signed [4:0] k_val2_2comp; 
wire signed [4+ES:0] total_exp1wire signed [4+ES:0] total_exp2)
wire signed [5+ES:0] result_exp; 
wire [2*(INP_SIZE-3-ES)+1:0] result_frac; reg signed [6+ES:0] result_exp_norm;
wire [6+ES:0] result_exp_abs;
wire [3:0] result_frac_MSB_index;
reg [3:0] result_frac_MSB_index_final;// 
reg signed [6+ES:0] result_regime;
wire [ES-1:0] result_exp_posit; // same as input exp bits
wire sign_bit;
reg [3:0] result_k_val;
wire [INP_SIZE-1:0] product_intermediate;
wire [2:0] result_regime_end_index;
wire [INP_SIZE-1:0] exponent_inserter;
wire [INP_SIZE-1:0] product_intermediate_exp;
wire [INP_SIZE-1:0] frac_inserter;
wire [INP_SIZE-1:0] product_unsigned;
wire [2*(INP_SIZE-3-ES)+1:0] frac_MSB_removed;
reg [INP_SIZE-1:0] product_prefinal;
integer i;
assign abs_inp1 = (inp1[INP_SIZE-1] == 1'b1) ? (~(inp1) + 1) : inp1;
assign abs_inp2 = (inp2[INP_SIZE-1] == 1'b1) ? (~(inp2) + 1) : inp2;
always@(*) begin
k_val1 = 0;
for (i=0; i<=INP_SIZE-3; i=i+1) begin
if (abs_inp1[i] == 1'b1) begin
k_val1 = INP_SIZE-2-i;
end
end
end
always@(*) begin
k_val2 = 0;
for (i=0; i<=INP_SIZE-3; i=i+1) begin
if (abs_inp2[i] == 1'b1) begin
k_val2 = INP_SIZE-2-i;
end
end
end
assign regime_end_index1 = INP_SIZE-2-k_val1;
assign regime_end_index2 = INP_SIZE-2-k_val2;
assign exp_extractor1 = {1'b1,{(INP_SIZE-ES-1){1'b0}},{(ES){1'b1}}} << 
(regime_end_index1-ES);
assign exp_extractor2 = {1'b1,{(INP_SIZE-ES-1){1'b0}},{(ES){1'b1}}} << 
(regime_end_index2-ES);
assign exp_intermediate1 = (abs_inp1 & exp_extractor1) >> (regime_end_index1-ES);
assign exp_intermediate2 = (abs_inp2 & exp_extractor2) >> (regime_end_index2-ES);
assign exp1 = exp_intermediate1[ES-1:0];
assign exp2 = exp_intermediate2[ES-1:0];
assign frac_extractor1 = ~({(INP_SIZE-1){1'b1}} << (regime_end_index1-ES));
assign frac_extractor2 = ~({(INP_SIZE-1){1'b1}} << (regime_end_index2-ES));
assign frac1_frac = abs_inp1 & frac_extractor1;
assign frac2_frac = abs_inp2 & frac_extractor2;
assign frac1_1_append = {{(INP_SIZE-2){1'b0}},1'b1} << (regime_end_index1-ES);
assign frac2_1_append = {{(INP_SIZE-2){1'b0}},1'b1} << (regime_end_index2-ES);
assign frac1 = frac1_frac | frac1_1_append;
assign frac2 = frac2_frac | frac2_1_append;
prepare
assign k_val1_2comp = ~(k_val1)+1; 
assign k_val2_2comp = ~(k_val2)+1;
assign total_exp1 = (k_val1_2comp<<ES) + exp1;
assign total_exp2 = (k_val2_2comp<<ES) + exp2;
assign result_exp = total_exp1 + total_exp2;
assign result_frac = frac1 * frac2;
assign result_frac_MSB_index = 2 + regime_end_index1-2 + regime_end_index2-2 - 1 ;
always@(*) begin
if (result_frac[result_frac_MSB_index]==1) begin
result_exp_norm = result_exp + 1;
result_frac_MSB_index_final = result_frac_MSB_index-1; 
end
else begin
result_exp_norm = result_exp;
result_frac_MSB_index_final = result_frac_MSB_index-2;
end
end
assign result_exp_abs = ~(result_exp_norm) + 1;
always@(*) begin
if (result_exp_abs < ({{(ES){1'b0}},1'b1} << ES) ) begin
result_k_val = 1 ;
result_regime = 0;
end
else begin
if((result_exp_abs % ({{(ES){1'b0}},1'b1} << ES)) == 0) begin
result_regime = result_exp_abs >> ES;
result_k_val = result_regime[3:0];
end
else begin
result_regime = (result_exp_abs >> ES) + 1;
result_k_val = result_regime[3:0];
end
end
end
assign result_exp_posit = result_exp_norm + (({{(ES){1'b0}},1'b1} << ES)*(result_k_val));
assign product_intermediate = {1'b1,{(INP_SIZE-1){1'b0}}} >> (result_k_val+1);
assign result_regime_end_index = INP_SIZE-1-result_k_val-1;
assign exponent_inserter = {{(INP_SIZE-ES){1'b0}},result_exp_posit} << 
(result_regime_end_index-ES);
assign product_intermediate_exp = product_intermediate | exponent_inserter; // product with
exp value encoded
assign frac_MSB_removed = result_frac << ((2*(INP_SIZE-3-ES)+1) -
(result_frac_MSB_index_final));
assign frac_inserter = frac_MSB_removed >> (((2*(INP_SIZE-3-ES)+1)-(INP_SIZE-1)) + 
(result_k_val+1+1+ES));
assign product_unsigned = product_intermediate_exp | frac_inserter;
always@(*) begin
if (inp1[INP_SIZE-1]^inp2[INP_SIZE-1]==1) begin
product_prefinal = ~(product_unsigned) + 1;
end
else begin
product_prefinal = product_unsigned;
end
end
assign product = ((inp1 & inp2) == 0) ? {(INP_SIZE){1'b0}} : product_prefinal;
endmodule
