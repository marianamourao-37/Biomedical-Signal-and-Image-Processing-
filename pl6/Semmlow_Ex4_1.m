%  Example  4-1 and Figures 4-2 and 4-3
%  Plot the frequency characteristics and impulse response
%  of a linear digital system with the given digital Transfer function
%  Edited by Pedro Cavaleiro Miranda, 17 Mar 2016
%
close all; clear all;

fs = 1000;					% Sampling frequency
N = 512;					% Number of points
%  Define a and b coefficients based on H(z)
a = [1 -.2 .8];
b = [.2 .5];
% Plot the frequency characteristic of H(z) using the fft
H = fft(b,N)./fft(a,N);		    % Compute H(f)
Hm = 20*log10(abs(H));          % Get magitude in db
Theta = radtodeg(angle(H));     %   and phase in deg. 
f = (0:N/2-1)*fs/N;				% Frequency vector for plotting
% f = (1:N/2)*fs/N;				% Frequency vector for plotting
subplot(2,1,1); 
plot(f,Hm(1:N/2),'k');			% Plot and label magnitude of H(f)
xlabel ('Frequency (Hz)');
ylabel('|H(z)| (db)');
grid on;                        % Plot using grid lines
subplot(2,1,2); 
plot(f,Theta(1:N/2),'k');		% Repeat for phase 
xlabel ('Frequency (Hz)');
ylabel('Phase (deg)');
grid on;                        % Plot using grid lines
% Compute the Impulse Response
x = [1, zeros(1,N-1)];		    % Generate an impulse function
h = filter(b,a,x);				% Apply b and a to impulse using Eq. 4-6 
figure; % New figure
subplot(2,1,1);
t = (0:N-1)/fs;
% t = (1:N)/fs;
plot(t(1:60),h(1:60),'k');		% Plot only the first 60 points for clarity
xlabel('Time (s)');			    % Labels
ylabel ('Impulse Response');
grid on;
% Compute the transfer function from the Impulse Response, P C Miranda
H = fft(h);
subplot(2,1,2);
plot(f,20*log10(abs(H(1:N/2))),'k');
xlabel ('Frequency (Hz)');
ylabel('|H(f)| (db)');
grid on;