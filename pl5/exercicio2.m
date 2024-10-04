clear, close all; 
clear all; close all;
fs = 1000;              % Assumed sampling freq -> nao foi dada em lado algum 
N = 128;                %n� pontos do sinal
[x,t,~]= sig_noise([235 250],-3,N); % Get data (235, 250 Hz sin plus white noise); 
%gera dois senos, com duas frequencias de corte, com ruido, senod a razao 
%sinal ruido -3dB sendo mais ruido do que sinal, tendo-se N=128 pontos.  
T = N/fs;
%t = (0:N-1)/fs; 
f = (0:N-1)/T; 

fft_sinal = abs(fft(x));
figure(1); 
subplot(2,1,1),plot(t,x); 
title('sinal no dominio temporal'); 
xlabel('tempo (s)');
ylabel('sinal'); 
subplot(2,1,2),plot(f(1:N/2),fft_sinal(1:N/2));
title('sinal no dominio espectral')
xlabel('frequ�ncia (Hz)');
ylabel('magnitude FFT');

%como os dois picos sao pr�ximos e t�m aproximadamente a mesma amplitude 
%(pico de interesse tem maior amplitude, pelo que spectral leakage nao � 
%um problema), e picos adjacentes nao t�m a mesma amplitude (->pouco spectral leakage
%desses picos sobre os de interesse) -> poder-se-� aplicar uma janela
%interm�dia que ofere�a um bom compromisso entre resolu��o em frequ�ncia e
%diminui��o de spectral leakage, mas devido ao facto de spectral leakage
%nao ser um problema, poder-se-� aplicar uma janela com muito boa resolu��o
%em frequ�ncia --> janela retangular 

r = window(@rectwin,N);
h = window(@hamming,N); 
b = window(@blackmanharris,N);

%dominio temporal:
xr = x.*r'; 
xh = x.*h'; 
xb = x.*b';

fft_xr = abs(fft(xr));
fft_xh = abs(fft(xh));
fft_xb = abs(fft(xb));

%dominio espectral:
fft_r = fft(r);
fft_h = fft(h);
fft_b = fft(b);
fft_x = fft(x);

%PERGUNTAR SE EST� BEM AO PROF:
or = abs(conv(fft_x,fft_r));
oh = abs(conv(fft_x,fft_h));
ob = abs(conv(fft_x,fft_b));
or = or(1:N);
oh = oh(1:N);
ob = ob(1:N);

figure(2);
subplot(3,1,1),plot(f(1:N/2),fft_xr(1:N/2));
title('janela retangular')
xlabel('frequ�ncia (Hz)');
ylabel('magnitude FFT');
subplot(3,1,2),plot(f(1:N/2),fft_xh(1:N/2));
title('janela hamming')
xlabel('frequ�ncia (Hz)');
ylabel('magnitude FFT');
subplot(3,1,3),plot(f(1:N/2),fft_xb(1:N/2));
title('janela blackmanharris')
xlabel('frequ�ncia (Hz)');
ylabel('magnitude FFT');

figure(3);
subplot(3,1,1),plot(f(1:N/2),or(1:N/2));
title('janela retangular')
xlabel('frequ�ncia (Hz)');
ylabel('magnitude FFT');
subplot(3,1,2),plot(f(1:N/2),oh(1:N/2));
title('janela hamming')
xlabel('frequ�ncia (Hz)');
ylabel('magnitude FFT');
subplot(3,1,3),plot(f(1:N/2),ob(1:N/2)); 
title('janela blackmanharris')
xlabel('frequ�ncia (Hz)');
ylabel('magnitude FFT');