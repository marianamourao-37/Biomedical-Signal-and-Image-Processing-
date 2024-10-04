load('106m.mat'); 
MLII = detrend(val(1,:)); %a primeira linha da matriz val corresponde 
%à derivação MLII (fazendo-se detrend)
V1 = detrend(val(2,:));  % Look for PVC in V1
signal = V1;
N = length(V1);
fs = 360; %the recordings qere digitalized at 360 samples, sendo que no 
%momento 4,24 minutos ocorre a premature ventricular contractions
t = (0:N-1)/fs;      

figure(1);
subplot(2,2,1),plot(t,signal);
title('ECG Signal');
xlabel('Time(sec)'); ylabel('mV');
subplot(2,2,2),plot(t,signal);
axis([170 180 min(signal) max(signal)]);
title('ECG Signal Zoomed in');
xlabel('Time(sec)'); ylabel('mV');

%taquicardia está representada em 2 segundos -> 3 contrações ventriculares
%observadas
twin = 2; 
nwin = fix(twin*fs);
nover = fix(0.5*nwin);

subplot(2,1,2),spectrogram(signal,nwin,nover,nwin*2,fs,'yaxis');