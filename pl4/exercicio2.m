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

dirac = [1,zeros(1,N-1)]; 
step = ones(1,N); 

conv_dirac = conv(eeg_detrend,dirac); 
conv_step = conv(eeg_detrend,step); 

Nd = N + N -1 
fd = (0:Nd-1)*fs/Nd;
%conv_dirac = conv_dirac(1:N); 
%conv_step = conv_step (1:N); %faz-se mesmo assim?

fft_eegdetrend = abs(fft(eeg_detrend));
fft_convdirac = abs(fft(conv_dirac));
fft_convstep = abs(fft(conv_step));

figure(1); 
subplot(2,1,1),plot(f(1:N/2),fft_eegdetrend(1:N/2)); 
xlabel('frequencies (Hz)');
ylabel('Magnitude of fft eeg');
title('fft of egg')
subplot(2,1,2),plot(fd(1:fix(Nd/2)),fft_convdirac(1:fix(Nd/2)));
xlabel('frequencies (Hz)');
ylabel('Magnitude of fft');
title('fft of impulse response');

figure(2); 
subplot(2,1,1),plot(f(1:N/2),fft_eegdetrend(1:N/2)); 
xlabel('frequencies (Hz)');
ylabel('Magnitude of fft');
title('fft of egg')
subplot(2,1,2),plot(fd(1:fix(Nd/2)),fft_convstep(1:fix(Nd/2)));
xlabel('frequencies (Hz)');
ylabel('Magnitude of fft');
title('fft of step response');
