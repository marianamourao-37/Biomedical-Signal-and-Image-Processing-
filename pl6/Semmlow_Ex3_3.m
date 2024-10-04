% Example 3.3 Generate a data set consisting of two sine 
% waves closely spaced in frequency (235 Hz and 250 Hz)
% with added white noise in a 128 point array sampled at 1 kHz.
% The SNR should be - 3 dB.
%.  
clear all; close all;
fs = 1000;              % Assumed sampling freq
N = 128;
x = sig_noise([235 250],-3,N); % Get data (235, 250 Hz sin plus white noise) 
%

%
% f = (1:N)*fs/N;     % Frequency vector
f = (0:N-1)*fs/N;     % Frequency vector, corrected by P C Miranda
X_mag = abs(fft(x)); std(X_mag(100:128))
subplot(3,1,1);
plot(f(1:N/2),X_mag(1:N/2),'k');				% Plot FFT
xlabel('Frequency (Hz)','FontSize',14);
ylabel('{\itX(f)}','FontSize',14);
title('signal');
%
x1 = x .* hamming(N)';
X_mag = abs(fft(x1));std(X_mag(100:128))
subplot(3,1,2);
plot(f(1:N/2),X_mag(1:N/2),'k');				% Plot FFT
xlabel('Frequency (Hz)','FontSize',14);
ylabel('{\itX(f)}','FontSize',14);
title('signal * Hamming');
%
x1 = x .* blackmanharris(N)';
X_mag = abs(fft(x1));std(X_mag(100:128))
subplot(3,1,3);
plot(f(1:N/2),X_mag(1:N/2),'k');				% Plot FFT
xlabel('Frequency (Hz)','FontSize',14);
ylabel('{\itX(f)}','FontSize',14);
title('signal * Blackman-Harris');
