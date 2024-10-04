close, clear all; 

data_org =importdata('ecgsamples_e0103.txt','\t',2);
ecg = data_org.data; 

ecg_v4 = ecg(:,1);
fs = 250; %dado do enunciado, nao está contido na estrutura 
N = length(ecg_v4);
T = N/fs;
f = (0:N-1)/T;
ecg_v4_detrend = detrend(ecg_v4); 
fft_ecg = abs(fft(ecg_v4_detrend));

bnum = 16;
b = ones(1,bnum)/bnum;
t = (0:bnum-1)/fs;

%output por convolução:
out_conv = conv(ecg_v4_detrend,b); 
out_conv = out_conv(1:N);
fft_out_conv = abs(fft(out_conv)); 

%output pelo comando filter: 
out_filter = filter(b,[1],ecg_v4_detrend);
fft_out_filter = abs(fft(out_filter)); 

%espectro da função de transferencia do filtro (com mais pontos):
nfft = 256;
f1 = (0:nfft-1)*fs/nfft;
Habs = abs(fft(b,nfft)); 
Hangle = radtodeg(angle(fft(b,nfft)));

%espectro da função de transferencia do filtro, atraves da resposta
%impulsiva:
dirac = [1,zeros(1,nfft-1)]; 
h = filter(b,[1],dirac);
fft_h = abs(fft(h));

%espectro da função de transferencia do filtro (com menos pontos):
Habs1 = abs(fft(b)); %H=fft(b)/fft(a), mas como é filtro fir fft(a) = 1.
f2 = (0:bnum-1)*fs/bnum;

figure(1); 
subplot(3,1,1),plot(f1(1:nfft/2),fft_h(1:nfft/2)); 
xlabel ('Frequency (Hz)');
ylabel('|H(z)|');
subplot(3,1,2),plot(f1(1:nfft/2),Hangle(1:nfft/2));
xlabel ('Frequency (Hz)');
ylabel('Phase (deg)');
subplot(3,1,3),plot(f1(1:nfft/2),Habs(1:nfft/2));
xlabel ('Frequency (Hz)');
ylabel('|H(z)|');

figure(2); 
plot(f2(1:bnum/2),abs(Habs1(1:bnum/2)));
title('fft resultante do comando filter com menos pontos');
xlabel('frequência (Hz)');
ylabel('magnitude FFT');

figure(3); 
subplot(3,1,1),plot(f(1:N/2),fft_ecg(1:N/2));
title('fft da derivação v4');
xlabel('frequência (Hz)');
ylabel('magnitude FFT');
subplot(3,1,2),plot(f(1:N/2),fft_out_conv(1:N/2));
title('fft resultante do comando conv');
xlabel('frequência (Hz)');
ylabel('magnitude FFT');
subplot(3,1,3),plot(f(1:N/2),fft_out_filter(1:N/2));
title('fft resultante do comando filter');
xlabel('frequência (Hz)');
ylabel('magnitude FFT');
