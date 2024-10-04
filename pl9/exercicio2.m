clear, close all;
[I map] = imread('blood1.tif');     % Input image 
if isempty(map) == 0                % Check to see if Indexed data
    I = ind2gray(I,map);            % If so, convert to Intensity image
else 
    I = im2double(I);               % Convert to double and scale
end                                 %   if not already

sigma = 10;
if mod(sigma,2) == 0
    hsize = sigma*6+1;
else
    hsize = sigma*6;
end 

h_g = fspecial('gaussian',hsize,sigma);     % hsize = 8, sigma = 2
I_lowgauss = imfilter(I,h_g);       % Gaussian filter

%tentei por em termos de frequências reais (?):
%RI = imref2d(size(I));
%RI.XWorldLimits = [0 ]; 
%RI.YWorldLimits = [0 ]; 

figure(1);
subplot(2,2,1);imshow(I); title('Imagem original');
xlabel('N pixel coordinate','FontSize',10); ylabel('M pixel coordinate','FontSize',10);

subplot(2,2,2);imshow(mat2gray(fftshift(20*log10(abs(fft2(I)))))); title('FFT2 da imagem original');
xlabel('Horizontal Frequency','FontSize',10); ylabel('Vertical Frequency','FontSize',10);

subplot(2,2,3);imshow(I_lowgauss); title('Imagem após filtragem low-pass');
xlabel('N pixel coordinate','FontSize',10); ylabel('M pixel coordinate','FontSize',10);

subplot(2,2,4);imshow(mat2gray(fftshift(20*log10(abs(fft2(I_lowgauss)))))); 
title('FFT2 da imagem após low-pass');
xlabel('Horizontal Frequency','FontSize',10); ylabel('Vertical Frequency','FontSize',10);

figure(2); 
mesh(fftshift(abs(fft2(h_g)))); title('Surface Plot da resposta em frequencia do filtro gaussiano');
colormap(hot); caxis([0 2]);
xlabel('Horizontal Frequency','FontSize',10); ylabel('Vertical Frequency','FontSize',10);
zlabel('Magnitude','FontSize',10);

figure(3); 
imshow(fftshift(abs(fft2(h_g)))); title('Resposta em frequência do filtro gaussiano em 2D');
xlabel('Horizontal Frequency','FontSize',10); ylabel('Vertical Frequency','FontSize',10);
