import math
def bin_to_posit(binary_str):
comp=""
check=comp.zfill((len(binary_str)))
print("length of str",len(binary_str))
print("check", check)
if binary_str==check:
print("inside if")
return binary_str
else:
print("inside else")
def twos_complement(binary_string):
if not binary_string:
raise ValueError("Input string is empty.")
if binary_string[0] == '1':
inverted = ''.join('1' if bit == '0' else '0' for bit in binary_string)
twos_comp = bin(int(inverted, 2) + 1)[2:] 
twos_comp = twos_comp.zfill(len(binary_string))
return twos_comp
else:
print(twos_complement(binary_str)) 
intvalue= int(twos_complement(binary_str),base=2)
intvalue=intvalue/(2**(len(binary_str)-1))
print("intvalue ",intvalue)
es=2
useed= 2**(2**es)
k=0
def adjust_to_useed_range(num,k):
if num == 0:
return num
else :
while num < 1 or num >= useed:
if num < 1:
num *= useed # Multiply by useed if less than 1
k -= 1
elif num >= useed:
num /= useed # Divide by 16 if greater than or equal to useed
k += 1
return num,k
'''try:
number = intvalue
result = adjust_to_range(number)
print(f"The number adjusted to the range [1, 16) is: {result}")
except ValueError as e:
print(f"Error: {e}")'''
uscale,k=adjust_to_useed_range(intvalue,k)
print("uscale ",uscale, "k value ",k)
exp=0
def adjust_to_two_range(num,exp):
while not (1 <= num < 2):
num /= 2 # Divide by 2 only because the useed scaling factor has made the value >1
exp+=1
return num,exp
number = float(input("Enter a number: "))
adjusted_number = adjust_to_range(number)
print(f"The adjusted number within range [1, 16) is: {adjusted_number}")
except ValueError as e:
print(f"Error: {e}")'''
normalized_value,exp=adjust_to_two_range(uscale,exp)
print("fraction value ",normalized_value," and exponent value",exp)
def separate_decimal_fraction(num):
fractional_part, integer_part = math.modf(num)
return int(integer_part), fractional_part
integer,fraction=separate_decimal_fraction(normalized_value)
print("fraction part", fraction, "and integer part", integer )
mantissa_decimal= int(fraction*(2**(len((binary_str))-1)))
print("mantissa in decimal ",mantissa_decimal)
mantissa_binary=bin(mantissa_decimal)[2:]
mantissa_binary=mantissa_binary.zfill((len(binary_str)-1))
print("mantisssa in binary ", mantissa_binary)
exp_bin = format(exp, f'0{es}b')
print("exp_bin value",exp_bin)
def process_input(value):
if value >= 0:
result = "1" * (value + 1) + "0"
else:
result = "0" * abs(value) + "1"
return result
try:
input_value = int(input("Enter an integer: "))
output = process_input(input_value)
print(f"Output: {output}")
except ValueError:
print("Invalid input. Please enter an integer.")'''
regime_bits= process_input(k)
concat_op= "0"+ regime_bits + exp_bin + mantissa_binary
truncated_op= concat_op[:(len(binary_str))]
ip_signbit= binary_str[0]
if ip_signbit==1 :'''
def p_twos_complement(binary_string,ip_signbit):
if not binary_string:
raise ValueError("Input string is empty.")
if ip_signbit == '1':
inverted = ''.join('1' if bit == '0' else '0' for bit in binary_string)
twos_comp = bin(int(inverted, 2) + 1)[2:] #removes the '0b' prefix
twos_comp = twos_comp.zfill(len(binary_string))
return twos_comp
else:
posit_no= p_twos_complement(truncated_op,ip_signbit)
print("binary no ",binary_str)
print("posit number ",posit_no)
return posit_no
input_file_path= "C:\\babu\\college related\\7th sem\\Project\\Codes\\test_inputs.txt"
output_file_path= "C:\\babu\\college related\\7th 
sem\\Project\\Codes\\test_inputs_posit_converted.txt"
with open(input_file_path, 'r') as input_file, open(output_file_path, 'w') as output_file:
for line in input_file:
print(line)
processed_line = bin_to_posit(line.strip())
output_file.write(processed_line + "\n")
print("Processing complete. Check the output file.")
