function [waveform_noise, time, waveform, snr_out] = sig_noise(freqsin, snr, npts);
% [waveform_noise, time, waveform, snr_out] = sig_noise(freqsin, snr, npts);
% Function to generate test data Generates sinusoids in noise.
%
% freqsin   		is a vector specifing the frequency of sinusoid(s) 
%              		    assuming a sample frequency of 1 KHz
%						One sinusoid of amplitude 1 is generated for each entry
% snr   			is a vector the SNR values in db of the associated sinusoid
%                       if snr is a scalor it is used for all frequencies 
% npts    			number of points in the array
% waveform_noise	is the output vector containing sinusoids and noise
% waveform			is the output containing only sinusoids
% time     			is the time vector useful in ploting the waveform
%						i.e., plot(time,waveform)
%
%
fs = 1000;   	% Assume a sampling freq of 1 kHz
% fs = 100;       % AA 28/2/2012

Ts = 1/fs;
time = (0:(npts-1))*Ts;
noise = randn(1,npts);  	% Generate noise and calculate RMS value 
rms_noise = sqrt(mean(noise.^2));
if length(snr) < length(freqsin) &  length(snr) == 1    % Check SNR vector length
    snr(2:length(freqsin)) = snr(1);
elseif length(snr) < length(freqsin)    
    disp('Error: not enough SNR values')
    waveform_noise = rms_noise;
    return
end    
%
for i = 1:length(freqsin)
   freq_scale = freqsin(i) * 2 * pi/fs;
   x = (1:npts) * freq_scale;
   snr_n = 10^(snr(i)/20);		% Convert from db
   A = snr_n * rms_noise * 1.414; % Determine gain for appropriate SNR
   if i == 1
     component = sin(x) * A;
      waveform = component;
   	rms_sig(i) = sqrt(mean(waveform.^2));  
   else
      component = sin(x) * A;
      rms_sig(i) = sqrt(mean(component.^2));
      waveform = waveform + component;
   end
   snr_out(i) = 20 * log10(rms_sig(i)/rms_noise);   
end
waveform_noise = waveform + noise;