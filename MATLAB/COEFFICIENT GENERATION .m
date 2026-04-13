clear all;
close all;
clc;
Fs = 256; %sampling frequency
N = 33 ;%taps
no_of_bits = 9;
f1 = 8;%7.4;%7.4; %7.59
f2 = 13;%13.61;%13.61; %13.42
f = [f1 f2]/(Fs/2); %normalised frequency
hc_unquantised = fir1(N-1, f,'bandpass',kaiser(N,5.65)); % coefficients
no_of_bits = 9;
x_quant_floor = floor(hc_unquantised*2^(no_of_bits))/2^(no_of_bits);
x_quant_ceil = ceil(hc_unquantised*2^(no_of_bits))/2^(no_of_bits);
x_quant = zeros(1,N);
for i = 1:N
if (hc_unquantised(i) - x_quant_floor(i)) >= (x_quant_ceil(i) - hc_unquantised(i))
x_quant(i) = x_quant_ceil(i);
else
x_quant(i) = x_quant_floor(i);
end
end
for i = 1:N
if(x_quant(i) == -0)
x_quant(i) = 0;
end
end
x_quant1 = fi(hc_unquantised,1,10,9);
error = x_quant1 - x_quant
fft_points=4096; %4096 point fft
fft_val= 20*log10(abs(fftshift(fft(hc_unquantised,fft_points)))); %fft from -fs/2 to fs/2
freq_x_axis=(-0.5:1/fft_points:0.5-1/fft_points)*Fs; %to display freq on x-axis
figure
plot(freq_x_axis,fft_val)
title('Gamma - Filter Frequency Response (Unquantised coefficients)')
xlabel("Frequency")
ylabel("Magnitude (dB)")
grid on
hold on
three_db_line = (-3) * ones(1, length(freq_x_axis)); %-3dB line
plot(freq_x_axis,three_db_line)
fft_points=4096; %4096 point fft
fft_val= 20*log10(abs(fftshift(fft(x_quant,fft_points)))); %fft from -fs/2 to fs/2
freq_x_axis=(-0.5:1/fft_points:0.5-1/fft_points)*Fs; %to display freq on x-axis
figure
plot(freq_x_axis,fft_val)
title('alpha- Filter Frequency Response (10-Bit Quantized coefficients)')
xlabel("Frequency")
ylabel("Magnitude (dB)")
grid on
hold on
three_db_line = (-3) * ones(1, length(freq_x_axis)); %-3dB line
plot(freq_x_axis,three_db_line)
hc_posit = readmatrix('Coefficients_Final\decimal_equivalent_of_posit\alpha_p_to_d.txt')
fft_points=4096; %4096 point fft
fft_val= 20*log10(abs(fftshift(fft(hc_posit,fft_points)))); 
freq_x_axis=(-0.5:1/fft_points:0.5-1/fft_points)*Fs; 
figure
plot(freq_x_axis,fft_val)
title('alpha- Filter Frequency Response (10-bit Posit coefficients)')
xlabel("Frequency")
ylabel("Magnitude (dB)")
grid on
hold on
three_db_line = (-3) * ones(1, length(freq_x_axis)); %-3dB line
plot(freq_x_axis,three_db_line)
