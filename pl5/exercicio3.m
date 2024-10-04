clear,close all;

data_org =importdata('ecgsamples_e0103.txt','\t',2);
ecg = data_org.data; 

ecg_v4 = ecg(:,1);
fs = 250; %dado do enunciado, nao está contido na estrutura 
N = length(ecg_v4);
T = N/fs;

ecg_v4_detrend = detrend(ecg_v4); 

f = (0:N-1)/T;
t = (0:N-1)/fs;

%visto o sinal ecg ter uma freuqência que desejávelmente deve estar bem
%definida em 1Hz, a amplitude das outras frequências deve ser reduzida ->
%spectral leake nao é um problema supostamente. 
janelas = {@rectwin;@hamming;@blackmanharris};
legenda = ["retangular","hamming","blackmanharris"];
for i=1:length(janelas)
    [PS,f] = pwelch(ecg_v4_detrend,window(janelas{i},fix(N/10)),fix(0.7*fix(N/10)),N,fs);
    figure(1);
    subplot(3,1,i),plot(f,10*log10(PS)); 
    ylabel('Pxx'); 
    xlabel('frequências físicas (Hz)');
    axis([0 fs/2 min(10*log10(PS)) max(10*log10(PS))]);
    title(['janela',legenda(i)]);
end
   