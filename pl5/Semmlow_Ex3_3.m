% Example 3.3 Generate a data set consisting of two sine 
% waves closely spaced in frequency (235 Hz and 250 Hz)
% with added white noise in a 128 point array sampled at 1 kHz.
% The SNR should be - 3 dB.
%.  
clear all; close all;
fs = 1000;              % Assumed sampling freq
N = 128;                %nº pontos do sinal
x = sig_noise([235 250],-3,N); % Get data (235, 250 Hz sin plus white noise); 
%gera dois senos, com duas frequencias de corte, com ruido, senod a razao 
%sinal ruido -3dB sendo mais ruido do que sinal, tendo-se N=128 pontos.  
%

%
% f = (1:N)*fs/N;     % Frequency vector
f = (0:N-1)*fs/N;     % Frequency vector, corrected by P C Miranda 
%(frequencias discretas), frequencias de 0 a N-1 em passos de deltaf=fs/N
X_mag = abs(fft(x)); std(X_mag(100:128))
subplot(3,1,1);
plot(f(1:N/2),X_mag(1:N/2),'k');				% Plot FFT de metade do sinal 
xlabel('Frequency (Hz)','FontSize',14);
ylabel('{\itX(f)}','FontSize',14);
title('fft signal');
%
hammingwindow = load('hamming_windowdesigner.mat')
g = hammingwindow.hamming_windowdesigner
x1 = x .* g'; %janela aplicada aos mesmo N pontos, nao estando a 
%reduzir a dimensao do sinal, com os valores nas pontas diminuidos.
%hamming(N) contem as amplitudes da janela de hamming.ATENÇÃO À TRANSPOSTA.
X_mag = abs(fft(x1));std(X_mag(100:128))
subplot(3,1,2);
plot(f(1:N/2),X_mag(1:N/2),'k');				% Plot FFT
xlabel('Frequency (Hz)','FontSize',14);
ylabel('{\itX(f)}','FontSize',14);
title('signal * Hamming');
%
x1 = x .* blackmanharris(N)'; %multiplicação ponto a ponto, em que x é um 
%vetor linha e blackmanharris(N) é um vetor coluna, pelo que se tem de fazer 
%a transposta de um dos sinais. caso contrario dava um escalar. 
%(no exame gerar a base temporal, de modo a por o eixo do x em segundos ou 
%frequencias em hz, e por as unidades(label)
X_mag = abs(fft(x1));std(X_mag(100:128))
subplot(3,1,3);
plot(f(1:N/2),X_mag(1:N/2),'k');				% Plot FFT
xlabel('Frequency (Hz)','FontSize',14);
ylabel('{\itX(f)}','FontSize',14);
title('signal * Blackman-Harris');

