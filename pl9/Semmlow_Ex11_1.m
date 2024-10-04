% Example 11.1  Plots figures 11.3, and 11.4
%  Two-dimensional Fourier Transform of a simple object.
%  Construct a simple 3 by 11 pixel rectangular object, or bar.
%  Take the Fourier Transform padded to 128 by 128 and plot the 
%  result as a 3 dimensional function (using mesh) and as an 
%  intensity image.
%
% Construct object
close all; clear all;

f = zeros(22,30);               % Original figure can be any size since it will be padded 
f(10:12,10:20)=1;               %3 by 11 pixel rectangular object (criado um retangulo branco)
nfft = 128;                      %faz zero padding da matriz f até ter dimensão 128 em x e em y 
ff = fft2(f,nfft,nfft);         % Take Fourier Transform, com o mesmo valor de zero-padding nas duas dimensões

F = abs(fftshift(ff));          % Shift center; get log magnitude

% show image
figure(1); imshow(f,'InitialMagnification','fit');         % Plot object
xlabel('X','FontSize',14); ylabel('Y','FontSize',14);
% show FFT, magnitude
figure(2); mesh(F); colormap(hot);         % Plot Fourier Transform as function
xlabel('Horizontal Frequency','FontSize',12); ylabel('Vertical Frequency','FontSize',12);
% mesh mostra a magnitude da transformada de Fourier como uma superficie e nao como uma imagem 2D
% axis([0 128 0 128 0 30]); 
% caxis([0 50]);

% show FFT, magnitude in dB 
F = 20*log10(F);                     % Take log function
I = mat2gray(F);                % Scale as intensity image
figure(3); imshow(I,'InitialMagnification','fit'); colormap(jet);       % Plot Fourier Transform as image
%figura numa escala logaritmica mas nao numa escala de cincentos (tem se um colormap): 
%-visao 2d dos picos (vista de cima da figura2)
xlabel('Horizontal Frequency','FontSize',14); ylabel('Vertical Frequency','FontSize',14);

%a fft vai ser senx/x pois tem se uma janela retangular (sequencias de 0's e 1's e 0's)
%largura do sen(x)/x depende da largura no dominio do tempo 

%a identificação das freqeuncias horizontais e verticais do grafico mesh (figura 2)
%está bem: 
%direção do quadrado branco é maior em x (perfil largo) --> fft2 é mais estreita 
%direção do quadrado branco é menor em y (perfil estreito) --> fft2 é mais
%larga 


