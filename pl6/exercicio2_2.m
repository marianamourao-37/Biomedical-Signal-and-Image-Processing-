clear,close all; 

data_org =importdata('ecgsamples_e0103.txt','\t',2);
ecg = data_org.data; 

ecg_v4 = ecg(:,1);
fs = 250; %dado do enunciado, nao está contido na estrutura 
N = length(ecg_v4);
T = N/fs;
t = (0:N-1)/fs;
f = ((0:N-1)*fs/N)/(fs/2);%(?)
V4detrend = detrend(ecg_v4); 

[b,a] = butter(8,30/(fs/2),'low'); 
y1 = filter(b,a,V4detrend);
y2 = filtfilt(b,a,V4detrend);

figure(1);
zoomin = 500;
plot(V4detrend(1:zoomin)); hold on;
plot([y1(1:zoomin) y2(1:zoomin)]);
legend('detrend signal','output of filter response','output of filtfilt response');

yfreq1 = fft(y1);
yfreq2 = fft(y2);
hm1 = 20*log10(abs(yfreq1));
hm2 = 20*log10(abs(yfreq2));

figure(2);
subplot(2,1,1), plot(f(1:N/2),hm1(1:N/2));
title('fft of filter');
subplot(2,1,2), plot(f(1:N/2),hm2(1:N/2));
title('fft of filtfilt');

%%
[z,p,k] = butter(8,30/(fs/2));
[sos,G] = zp2sos(z,p,k);
y1 = sosfilt(sos,V4detrend);
y2 = filtfilt(sos,G,V4detrend);

figure(3);
zoomin = 500;
plot(V4detrend(1:zoomin)); hold on;
plot([y1(1:zoomin) y2(1:zoomin)]);
legend('detrend signal','output of filter response','output of filtfilt response');

yfreq1 = fft(y1);
yfreq2 = fft(y2);
hm1 = 20*log10(abs(yfreq1));
hm2 = 20*log10(abs(yfreq2));

figure(4);
subplot(2,1,1), plot(f(1:N/2),hm1(1:N/2));
title('fft of filter');
subplot(2,1,2), plot(f(1:N/2),hm2(1:N/2));
title('fft of filtfilt');
