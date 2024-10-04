load('106m.mat'); 
MLII = detrend(val(1,:)); %a primeira linha da matriz val corresponde 
%à derivação MLII (fazendo-se detrend)
V1 = detrend(val(2,:));  % Look for PVC in V1
signal = V1;
N = length(V1);
fs = 360; %the recordings qere digitalized at 360 samples, sendo que no 
%momento 4,24 minutos ocorre a premature ventricular contractions
t = (0:N-1)/fs;          % Temporal Base (para se ver o mesmo em função do tempo) 

subplot(2,2,1); plot(t,signal);
axis tight;
hold on;
title('ECG Signal');
xlabel('Time(sec)'); ylabel('mV');
% Zoom in on single PVC at 4'23'', i.e., 263 sec (=4*60 + 23 = 263 sec)
subplot(2,2,2); plot(t,signal);
axis([262 268 -220 100]); %faz se um zoom, de modo a delimitar a 
%parte do eixo x que se quer ver
title('ECG Signal Zoomed in');
xlabel('Time(sec)'); ylabel('mV');

twind = 1;  % width of window, in s. 10 sec duration ensures 0.1Hz 
%(resolução espectral = 1/duração do sinal) spectral resolution; resoluçã 
%temporal de 10 segundos, fazendo-se uma media de batimentos, pelo que o 
%excecional está diluido. 

nwind = fix(twind*fs);  % width of Hamming window, in samples (nao está em 
%segundos a largura, mas em nº de amostras) deveria se ter feito o fix em nwind, 
%pois tem de ser um numero inteiro

%escolhe se uma resolução temporal má para se ter uma resolução espectral
%grande 
nwover = fix(nwind/2); % window overlap, in samples
% comando fix - arrendonda o valor para inteiro

subplot(2,1,2),spectrogram(signal, nwind, nwover, [], fs, 'yaxis');