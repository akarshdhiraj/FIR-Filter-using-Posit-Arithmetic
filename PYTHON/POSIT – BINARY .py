def posit_to_binary(posit_str):
comp=""
check=comp.zfill((len(posit_str)))
print("length of str",len(posit_str))
print("check", check)
if posit_str==check:
print("inside if")
return posit_str
else:
print("inside else")
def twos_complement(posit_string):
if not posit_string:
raise ValueError("Input string is empty.")
if posit_string[0] == '1':
inverted = ''.join('1' if bit == '0' else '0' for bit in posit_string)
twos_comp = bin(int(inverted, 2) + 1)[2:] #removes the '0b' prefix
twos_comp = twos_comp.zfill(len(posit_str))
return twos_comp
else:
return posit_string
two_comp= twos_complement(posit_str)
print("2's comp ", two_comp)
def k_value_from_regimebits(input_string):
k = 0
index_at_break = 0
if not input_string:
raise ValueError("Input string cannot be empty.")
starting_index=0
initial_char = input_string[starting_index]
if initial_char == '0':
print("inside 0 for")
m = 0
for i, char in enumerate(input_string):
print("i value",i)
print("char value",char)
if char == '0':
m += 1
elif char == '1':
k = -m
index_at_break = i+1
print("break at ",index_at_break)
break
elif initial_char == '1':
print("inside 1 for")
m = 0
for i, char in enumerate(input_string):
print("i value",i)
print("char value",char)
if char == '1':
m += 1
elif char == '0':
k = m - 1
index_at_break = i+1
break
if index_at_break == 0:
raise ValueError("No break condition found in the string.")
return k, index_at_break
k,indexbreak=k_value_from_regimebits(two_comp[1:])
print("k value", k)
print("index break value", indexbreak)
es=2
exp_bin=two_comp[(indexbreak+1):(indexbreak+es+1)]
print("exp binary value ", exp_bin)
exp=int((exp_bin),base=2)
print("exp value ",exp)
useed=2**(2**es)
_part_bin=two_comp[(indexbreak+es+1):]
print("fraction part", f_part_bin)
f_part_intermediate= int(f_part_bin,base=2)
f_part=f_part_intermediate/(2**(len(f_part_bin)))
print("fraction part in decimal", f_part)
f_part_posit=1+f_part
print("f_part_posit ",f_part_posit)
print("useed ",useed)
posit_deci=((-1)**(int(posit_str[0],base=2)))*(useed**(k))*(2**(exp))*f_part_posit
print("posit_decimal ",posit_deci)
return posit_deci
input_file_path= "C:\\babu\\college related\\7th 
sem\\Project\\Codes\\coeffs_gamma_unquantised_posit_converted.txt"
output_file_path= "C:\\babu\\college related\\7th 
sem\\Project\\Codes\\coeffs_gamma_unquantised_posit_converted_back_to_decimal.txt"
with open(input_file_path, 'r') as input_file, open(output_file_path, 'w') as output_file:
for line in input_file:
print(line)
processed_line = posit_to_binary(line.strip())
output_file.write(f"{processed_line}\n" )
print("Processing complete. Check the output file.")
