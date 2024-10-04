clear, close all; 

data_org = importdata('eeg_data.mat');

trial = -1;
channel = -1;
while (trial<0 | trial>61) & (channel<0 | channel > 64)
    trial = input('Escolha um trial de [1-61]: ');
    channel = input('Escolha um channel de [1-64]: ');
end 

eeg = data_org.trial{trial}(channel,:);
eeg_detrend = detrend(eeg);

N = length(eeg_detrend);
fs = data_org.fsample;
T = N/fs;
f = (0:N-1)/T;
t = data_org.time{trial};

freq = input(['escolha uma frequência entre [0,',num2str(fs/2),'[: ']);

%o argumento no cos e sin tem de estar em radianos:
for i=1:N/2
    cosseno = cos(2*pi*f(i)*t); 
    seno = sin(2*pi*f(i)*t);
    real = conv(eeg_detrend,cosseno,'valid'); 
    img = conv(eeg_detrend,seno,'valid'); 
    %para o valid funcionar dim(eeg_detrend) = dim(cosseno) = dim(seno)
    mag(i) = sqrt(real.^2 + img.^2);
    
end 

fft_eeg = abs(fft(eeg_detrend)); 

figure(1);
plot(f(1:N/2),mag,'b*',f(1:N/2), fft_eeg(1:N/2),'r-o');
xlabel('frequencies (Hz)');
ylabel('Magnitude of fft');
title('fft of eeg'); 
legend('fft by convolution','fft by fft comand');


