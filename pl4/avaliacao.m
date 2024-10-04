clear all; close all;
N = 1024;						% Number of data points do sinal 
fs = 1000;					% Sampling frequency
[x,t,~] = sig_noise (250,-7,N); 	% Generate data; utilizando-se a rotina 
%sig_noise, gerando uma sinusoide com uma ferquencia de 250 hz, relação 
%sinal-ruido -7dB e N pontos; gera a base temporal 

N = [32 32;64 64;128 128;256 256;512 512;128 100;128 160];

for i=1:size(N,1)
    [PS,f] = pwelch(x, kaiser(N(i,1)),[],N(i,2),fs); 
    subplot(3,7,i), plot(f,10*log10(PS));			        % Plot in dB
    title(['kaiser - ',num2str(N(i,1)),' e ',num2str(N(i,2))],'FontSize',12)
    
    [PS,f] = pwelch(x, hamming(N(i,1)),[ ],N(i,2),fs);
    subplot(3,7,i+7), plot(f,10*log10(PS));					% Plot in dB
    title(['hamming - ',num2str(N(i,1)),' e ',num2str(N(i,2))],'FontSize',12);
    
    [PS,f] = pwelch(x, blackmanharris(N(i,1)),[],N(i,2),fs);
    subplot(3,7,i+14), plot(f,10*log10(PS));					% Plot in dB
    title(['blackman - ',num2str(N(i,1)),' e ',num2str(N(i,2))],'FontSize',11);
    
end

k = length(N);
%acho que as legendas para serem assim adicionadas têm de estar num subplot
%do mesmo tamanho que estão nos subplots traçados acima (3x7). k+1 e
%2*k+4,para estar no eixo de coordenadas dos subplots centrais:
subplot(3,k,k+1), ylabel('Power Spectrum','FontSize',20);
subplot(3,k,2*k+4), xlabel('Frequency (Hz)','FontSize',20); % legenda dos espetros