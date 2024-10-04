clear,close all;

data_org =importdata('ecgsamples_e0103.txt','\t',2);
ecg = data_org.data; 

ecg_v4 = ecg(:,1);
fs = 250; %dado do enunciado, nao está contido na estrutura 
N = length(ecg_v4);
T = N/fs;

ecg_v4_detrend = detrend(ecg_v4); 
ecg_v4_detrend_ds = interp(ecg_v4_detrend,4);

fft_v4_detrend = abs(fft(ecg_v4_detrend)); 
f = (0:N-1)/T;

nfft1 = fix(N*8);
fft_v4_detrend_z = abs(fft(ecg_v4_detrend,nfft1)); 
f1 = (0:nfft1-1)*fs/nfft1;

nfft2 = fix(N/8);
fft_v4_detrend_t = abs(fft(ecg_v4_detrend,nfft2));
f2 = (0:nfft2-1)*fs/nfft2;

fft_v4_detrend_d = abs(fft(ecg_v4_detrend_ds));
nd = fix(4*N);
f3 = (0: nd-1)*(2*fs)/nd;

figure(1); 
subplot(2,2,1),plot(f(1:N/2),fft_v4_detrend(1:N/2));
title('magnitude da fft v4 detrend')
xlabel('frequência (Hz)');
ylabel('magnitude FFT');

subplot(2,2,2),plot(f1(1:nfft1/2),fft_v4_detrend_z(1:nfft1/2));
title('magnitude da fft v4 zero-padding')
xlabel('frequência (Hz)');
ylabel('magnitude FFT');

subplot(2,2,3),plot(f2(1:nfft2/2), fft_v4_detrend_t(1:nfft2/2));
title('magnitude da fft v4 truncation')
xlabel('frequência (Hz)');
ylabel('magnitude FFT');

subplot(2,2,4),plot(f3(1:nd/2),fft_v4_detrend_d(1:nd/2));
title('magnitude da fft v4 downsampled')
xlabel('frequência (Hz)');
ylabel('magnitude FFT');
