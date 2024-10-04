data_org = importdata('eeg_data.mat');

trial = -1;
channel = -1;
while (trial<0 | trial>61) & (channel<0 | channel > 64)
    trial = input('Escolha um trial de [1-61]: ');
    channel = input('Escolha um channel de [1-64]: ');
end 

eeg = data_org.trial{trial}(channel,:);

N = length(eeg); 
fs = data_org.fsample;
T = N/fs;
f = (0:N-1)/T;
t = data_org.time{trial};

eeg_detrend = detrend(eeg); 

ffteeg = abs(fft(eeg));
ffteeg_detrend = abs(fft(eeg_detrend));

nfft = 1024;
ffteeg_nfft = abs(fft(eeg,nfft)); 
ffteeg_detrend_nfft = abs(fft(eeg_detrend,nfft)); 
f_nfft = (0:nfft-1)*fs/nfft;

figure(1); 
subplot(3,1,1),plot(f(1:N/2),ffteeg(1:N/2));
title('fft of eeg');
xlabel('frequencies (Hz)');
ylabel('Magnitude of fft eeg');
subplot(3,1,2),plot(f(1:N/2),ffteeg_detrend(1:N/2));
title('fft of eeg detrend');
xlabel('frequencies (Hz)');
ylabel('Magnitude of fft eeg');
subplot(3,1,3),plot(f(1:N/2),[ffteeg(1:N/2);ffteeg_detrend(1:N/2)]);
legend('fft of eeg','fft of eeg detrend');
xlabel('frequencies (Hz)');
ylabel('Magnitude of fft eeg');

figure(2); 
subplot(3,1,1),plot(f_nfft(1:nfft/2),ffteeg_nfft(1:nfft/2));
title('fft of eeg');
xlabel('frequencies (Hz)');
ylabel('Magnitude of fft eeg');
subplot(3,1,2),plot(f_nfft(1:nfft/2),ffteeg_detrend_nfft(1:nfft/2));
title('fft of eeg detrend');
xlabel('frequencies (Hz)');
ylabel('Magnitude of fft eeg');
subplot(3,1,3),plot(f_nfft(1:nfft/2),[ffteeg_nfft(1:nfft/2);ffteeg_detrend_nfft(1:nfft/2)]);
legend('fft of eeg','fft of eeg detrend');
xlabel('frequencies (Hz)');
ylabel('Magnitude of fft eeg');
