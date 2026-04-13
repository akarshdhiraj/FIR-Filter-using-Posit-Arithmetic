clear all;
close all;
Fs = 256;
dt = 1/Fs; 
fin1 = 40; 
fin2 = 15;
samples = 800;
cycles = fin1*samples/Fs;
%cycles = 15;
StopTime = (1/fin1)*cycles; 
t = (0:dt:StopTime); 
%%Sine wave:
x = 0.5 * sin(2*pi*fin1*t) %+ 0.5 * sin(2*pi*(fin2)*t);
total_samples = length(x)
no_of_bits = 14;
x_quant_floor = floor(x*2^(no_of_bits))/2^(no_of_bits);
x_quant_ceil = ceil(x*2^(no_of_bits))/2^(no_of_bits);
x_quant = zeros(1,total_samples);
for i = 1:total_samples
if (x(i) - x_quant_floor(i)) >= (x_quant_ceil(i) - x(i))
x_quant(i) = x_quant_ceil(i);
else
x_quant(i) = x_quant_floor(i);
end
end
for i = 1:total_samples
if(x_quant(i) == -0)
x_quant(i) = 0;
end
end
x_quant1 = fi(x,1,15,14);
error = x_quant1 - x_quant
x_filter_hdl = zeros(1,total_samples);
for i = 1:total_samples
x_filter_hdl(i) = x_quant1(i)*2^(no_of_bits);
if (x_quant(i)<0)
x_filter_hdl(i) = 2^(no_of_bits+1) + x_filter_hdl(i);
end
end
figure;
stem(t,x);
xlabel('time (in sec)');
ylabel("Amplitude")
title('Input Signal versus Time');
figure;
stem(t,x_quant1);
xlabel('time (in sec)');
ylabel("Amplitude")
title('Quantized Input Signal versus Time');
fft_points=4096; %4096 point fft
fft_val= 20*log10(abs(fftshift(fft(x_quant,fft_points)))); %fft from -fs/2 to fs/2
freq_x_axis=(-0.5:1/fft_points:0.5-1/fft_points)*Fs; %to display freq on x-axis
figure
stem(freq_x_axis,fft_val)
x_quant1
format long
writematrix(x_quant(:),"Inputs_final\raw_inputs\gamma_ip_raw.txt");
