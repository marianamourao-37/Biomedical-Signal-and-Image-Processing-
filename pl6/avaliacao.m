close, clear all; 

data_org =importdata('ecgsamples_e0103.txt','\t',2);
ecg = data_org.data; 

ecg_v4 = ecg(:,1);
fs = 250; %dado do enunciado, nao está contido na estrutura 
N = length(ecg_v4);
T = N/fs;
t = (0:N-1)/fs;
f = (0:N-1)/T;
ecg_v4_detrend = detrend(ecg_v4); 

fft_ecg_detrend = abs(fft(ecg_v4_detrend));
fft_ecg = abs(fft(ecg_v4));

figure(1); 
subplot(3,1,1),plot(f(1:N/2),fft_ecg(1:N/2));
xlabel('frequência (Hz)');
ylabel('magnitude FFT');
title('fft of signal');

subplot(3,1,2),plot(f(1:N/2),fft_ecg_detrend(1:N/2)); 
xlabel('frequência (Hz)');
ylabel('magnitude FFT');
title('fft of detrend signal');

load('avaliacao_iir.mat'); 
out = filtfilt(SOS,G,ecg_v4); 
fft_out = abs(fft(out)); 

load('avaliacao_fir.mat');
V4_fir = filtfilt(Num,[1],ecg_v4);
f_fir = abs(fft(V4_fir));

figure(1); 
subplot(3,1,3), plot(f(1:N/2),fft_out(1:N/2));
xlabel('frequência (Hz)');
ylabel('magnitude FFT');
title('fft of high-pass filtered signal');

figure(2);
plot(t,ecg_v4_detrend); hold on;
plot(t,V4_fir); hold on;
plot(t,out); grid on;
title('ECG Signals, Time Comparison, Zoomed');
xlabel('Time (s)'); ylabel('ECG Magnitude (mV)');
axis([0 10 -0.5 2]);
legend('Detrended Signal','Filtered FIR Signal','Filtered IIR Signal');

%%
%com atraso:
clear, close all;

% Read in ecg data
data_org = importdata('ecgsamples_e0103.txt','\t',2);
ecg = data_org.data;
V4 = ecg(:,1); % Original Signal
V4_detrend = detrend(V4); % Detrended Signal
fs = 250; % sampling frequency, in Hz
N = length(V4); % number of data points
T = N/fs; % signal duration, in s
t = (0:N-1)/fs; % Time vector.
f = (0:(N-1)/2)*(fs/N); % Frequencies vector.

% Applying the High Pass Filter to the Signal
load('avaliacao_iir_2.mat');
load('avaliacao_fir.mat');
%load('iir_fcmenor.mat');
V4_filtered = sosfilt(SOS,V4);
V4_fir = filter(Num,[1],V4);
F = 20*log10(abs(fft(V4)));
F_detrend = 20*log10(abs(fft(V4_detrend)));
F_filtered = 20*log10(abs(fft(V4_filtered)));
f_fir = 20*log10(abs(fft(V4_fir)));

%Plot of all signals

figure(1);
plot(t, V4); hold on; % Plot Original Signal
plot(t, V4_detrend); hold on; % Plot Detrended Signal
plot(t, V4_fir); hold on;
plot(t, V4_filtered); grid on; % Plot Filtered Signal
xlabel('Time (sec)'); ylabel('ECG Magnitude (mV)');
legend('Signal','Detrended Signal','Filtered FIR Signal','Filtered IIR Signal');
title('ECG Signals, Time Comparison');
axis([0 10 -0.5 2]);

figure(2);
plot(t,V4_detrend); hold on;
plot(t,V4_fir); hold on;
%plot(t,V4_filtered); grid on;

xlabel('Time (s)'); ylabel('ECG Magnitude (mV)');
legend('Detrended Signal','Filtered FIR Signal','Filtered IIR Signal');
axis([0 10 -0.5 2]); % Zooming in on the plot
title('ECG Signals, Time Comparison, Zoomed');

figure(3);
plot(f, F(1:N/2)); hold on;
plot(f, F_detrend(1:N/2)); hold on;
plot(f, F_filtered(1:N/2)); hold on;
plot(f, f_fir(1:N/2));grid on;
xlabel('Frquency (Hz)'); ylabel('Power (dB)');
legend('Signal','Detrended Signal','Filtered IIR Signal','Filtered FIR Signal');
axis([0 5 min(F) max(F)]); % Zooming in on the plot
title('ECG Signals, Frquency Comparison')