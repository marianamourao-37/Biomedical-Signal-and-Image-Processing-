clear,close all; 
fs = 1000;
N = 256;
t = 0:1/fs:2;
y = chirp(t,100,1,200,'q');

figure(1);
spectrogram(y,128,120,128,fs,'yaxis');
title('Chirp: start at 100Hz and cross 200Hz at t = 1sec');

figure(2);
pwelch(y,128,120,128,fs);
title('welch method');

figure(3); 
plot(t,y);