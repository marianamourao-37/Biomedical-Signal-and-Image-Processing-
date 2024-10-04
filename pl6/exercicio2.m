clear all; close all;
fs = 1000;              % Assumed sampling freq
N = 256;
f1 = 235;
f2 = 250;
[x,t,~] = sig_noise([f1 f2],-3,N); % Get data (235, 250 Hz sin plus white noise) 
fft_x = abs(fft(x));

figure(1);
plot(t,x);
xlabel('time (s)'); 
ylabel('sinal');
title('sinal do dominio temporal');

ordem = input('especifique a ordem do filtro passa-baixo FIR: '); 
% fc = ((f1+f2)/2)/(fs/2) = (f1+f2)/fs = wn
wn = (f1+f2)/fs;%pretende se que a frequencia de corte seja intermedia entre 
%as duas frequencias f1 e f2 

b = fir1(ordem,wn,rectwin(ordem+1)); 

out = filter(b,[1],x);
fft_out = abs(fft(out));
f = (0:N-1)*fs/N; 

figure(2); 
subplot(2,1,1),plot(f(1:N/2),fft_x(1:N/2)); 
title('sinal');
ylabel('magnitude da fft');
xlabel('Frequency (Hz)','FontSize',14);
subplot(2,1,2),plot(f(1:N/2),fft_out(1:N/2));
title('sinal filtrado');
xlabel('Frequency (Hz)','FontSize',14);
ylabel('magnitude da fft');
