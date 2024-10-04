fs = 1000;               % sampling frequency, in Hz

t = 0:1/fs:2;   %2 secs @ 1kHz sample rate
N = size(t,2);  % number of time points
f0 = 20;        % set fundamental frequency, in Hz
x = zeros (1,N);
nfreqs = 5;
npts = 200;
for k = 1:nfreqs
    x(npts*(2*k-1)+1:npts*2*k+1)= sin(2*pi*f0*k*t(npts*(2*k-1)+1:npts*2*k+1)); 
%f0*k para mudar a frequência fundamental de cada uma das sinusóides?
%2*k-1 = (2*k)-1 
%2*k+1 = (2*k)+1 
end

figure(1);
subplot(2,2,1); plot(t,x);
subplot(2,2,3); plot(t,x);
subplot(2,2,2); spectrogram(x,128,120,256,fs,'yaxis'); % Display the spectrogram
subplot(2,2,4); pwelch(x,128,120,256,fs);