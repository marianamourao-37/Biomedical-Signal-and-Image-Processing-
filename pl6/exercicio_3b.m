close, clear all; 

data_org =importdata('ecgsamples_e0103.txt','\t',2);
ecg = data_org.data; 

ecg_v4 = ecg(:,1);
fs = 250; %dado do enunciado, nao está contido na estrutura 
N = length(ecg_v4);
T = N/fs;
f = (0:N-1)/T;
ecg_v4_detrend = detrend(ecg_v4); 

f1 = 59/(fs/2);
f2 = 61/(fs/2);

[b,a] = butter(8,[f1 f2],'stop'); 
out2 = filtfilt(b,a,ecg_v4_detrend); 
fft_out2 = 20*log10(abs(fft(out2))); 
figure(2); 
plot(f(1:N/2),fft_out2(1:N/2));
title('fft of filtfilt response in matlab')
xlabel('frequência (Hz)');
ylabel('magnitude FFT');

[z,p,k] = butter(8,[f1 f2],'stop'); 
[sos,g] = zp2sos(z,p,k);
out = filtfilt(sos,g,ecg_v4_detrend); 
fft_out = 20*log10(abs(fft(out))); 

load('exercicio3b.mat'); 
out1 = filtfilt(SOS,G,ecg_v4_detrend); 
fft_out1 = 20*log10(abs(fft(out1))); 

figure(1); 
subplot(2,1,1),plot(f(1:N/2),fft_out(1:N/2));
title('fft of filtfilt response in matlab')
xlabel('frequência (Hz)');
ylabel('magnitude FFT');
subplot(2,1,2),plot(f(1:N/2),fft_out1(1:N/2));
title('fft of filtfilt response in filterDesigner')
xlabel('frequência (Hz)');
ylabel('magnitude FFT');
