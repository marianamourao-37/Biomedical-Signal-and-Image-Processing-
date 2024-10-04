data = importdata('eeg_chbmit_s1_3_ch9.mat');
signal = detrend(data);
N = length(signal);
fs = 256;            % sampling frequency, in Hz
T = N/fs;            % duration of acquisition, in sec
t = (0:N-1)/fs;      % Temporal Base

figure(1);
subplot(2,2,1),plot(t,signal);
title('EEG Signal');
xlabel('Time(sec)'); ylabel('mV');
subplot(2,2,2),plot(t,signal);
axis([2900 3200 min(signal) max(signal)]);
title('EEG Signal Zoomed in');
xlabel('Time(sec)'); ylabel('mV');
twin = 0.5;
nwin = fix(0.5*fs); 
nover = fix(0.5*nwin);
subplot(2,1,2),spectrogram(signal,nwin,nover,[],fs,'yaxis');
