data_org = importdata('eeg_data.mat'); 

trial = -1;
channel = -1;

while (trial <0 | trial>61) & (channel <0 | channel > 64)
    trial = input('escolha um trial entre [1,61]: ');
    channel = input('escolha um channel entre [1,64]: ');
end 

eeg = data_org.trial{trial}(channel,:);
eeg_detrend = detrend(eeg);

fs = data_org.fsample; 
N = length(eeg_detrend);
T = N/fs;

t = data_org.time{trial}; 
f = (0:N-1)/T;

RT = 1; 
[hrf,~]=spm_hrf(RT); 

convolucao = conv(eeg_detrend,hrf); 
%convolucao = convolucao(1:N); %faz-se mesmo assim?

fft_eeg = abs(fft(eeg_detrend));
fft_conv = abs(fft(convolucao));

figure(1); 
subplot(2,1,1),plot(f(1:N/2),fft_eeg(1:N/2));
xlabel('frequencies (Hz)');
ylabel('Magnitude of fft');
title('fft of eeg');
subplot(2,1,2),plot(f(1:N/2),fft_conv(1:N/2));
xlabel('frequencies (Hz)');
ylabel('Magnitude of fft');
title('fft of hemodinamic response');