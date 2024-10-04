% Example  3.4 and Figure 3.16
%  Apply Welch's method to sin plus noise data of Fig 3.9  
clear all; close all;
N = 1024;						% Number of data points do sinal 
fs = 1000;					% Sampling frequency
[x,t,] = sig_noise (250,-7,N); 	% Generate data; utilizando-se a rotina 
%sig_noise, gerando uma sinusoide com uma ferquencia de 250 hz, relação 
%sinal-ruido -7dB e N pontos; gera a base temporal 
%
% Estimate the Welch spectrum using 128 point segments, 
%      a the triangular filter, and a 50% overlap.(tem-se 15 segmentos no
%      total)
%
[PS,f] = periodogram(x, kaiser(N),N,fs); %N pontos para a TF 
subplot(2,2,1), plot(f,10*log10(PS));					% Plot in dB
%10*log10(PS) passa para uma escala logaritmica (dB). o que se sabia era
%que dB = 20log(A1/A2) (escala logaritmica é uma escala relativa). 
%power spectral density é uma razao de potencias,sendo dB = 10log(A1^2/A2^2)
xlabel('Frequency (Hz)'); ylabel('Power Spectrum');
title('periodogram - kaiser')
[PS,f] = pwelch(x, kaiser(N/8),[ ],N,fs); %overlap é igual (dai se por [ ]) 
subplot(2,2,2), plot(f,10*log10(PS));					% Plot in dB
xlabel('Frequency (Hz)'); ylabel('Power Spectrum');
title('pwelch - kaiser, 15 segments with 50% overlap') %15 ou 8 segmentos???
[PS,f] = periodogram(x, blackmanharris(N),N,fs);
subplot(2,2,3), plot(f,10*log10(PS));					% Plot in dB
xlabel('Frequency (Hz)'); ylabel('Power Spectrum');
title('periodogram - blackmanharris')
[PS,f] = pwelch(x, blackmanharris(N/8),[ ],N,fs);
subplot(2,2,4), plot(f,10*log10(PS));					% Plot in dB
xlabel('Frequency (Hz)'); ylabel('Power Spectrum');
title('pwelch - blackmanharris, 15 segments with 50% overlap')
% pwelch arguments
% 1- input data
% 2- window
% 3- default, NOVERLAP
% 4- NFFT
% 5- sampling frequency in Hz

%sinal é de 250 hz com ruido
%media dos 15 espectros, com melhoria na relação sinal ruido, sobressaindo
%o pico dos 250hz, perdendo-se em resolução espectral (picos aparecem mais
%largos), tendo-se tambem menos pontos. a primeira TF tinha 224 pontos
%tendo a outro 128 pontos. (tem-se menos pontos para definir os picos)
%alargamento do pico central devido a uma maior largura da janela
%blackmanharis 
