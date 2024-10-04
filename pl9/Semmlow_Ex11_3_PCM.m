% Example 11-3 and Figure 11.7 amd 11.8
%   Linear filtering. Load the blood cell image
% Apply a 32th order lowpass filter having a bandwidth of .125 fs/2, and a
%   highpass filter having the same bandwidth.  Implement the lowpass
%   filter using imfilter with the zero padding (the default) and with
%   replicated padding (extending the final pixels). --> para os pixels no
%   contorno da imagem. 
% Plot the filter characteristics of the high and low pass filters
%
% Modified by P C Miranda, 22 Abril 2015
%
% Load the image and transform if necessary
clear all; close all;
N = 32;                             % Filter order
w_lp = .125;                        % Lowpass cutoff frequency, Pi rad/s (frequêcnia normalizada = .125 fs/2)
w_hp = .125;                        % Highpass cutoff frequency, Pi rad/s (frequêcnia normalizada = .125 fs/2) 
[I map] = imread('blood1.tif');     % Input image 
if isempty(map) == 0                % Check to see if Indexed data
    I = ind2gray(I,map);            % If so, convert to Intensity image
else 
    I = im2double(I);               % Convert to double and scale
end                                 %   if not already
b_lp = fir1(N,w_lp);                   % Generate the lowpass filter, frequencia de ocrte entre 0 e 1 
h_lp = ftrans2(b_lp);                  % Convert to 2-dimensions
I_lowpass = imfilter(I,h_lp);       %    and apply
b_hp = fir1(N,w_hp,'high');            % Repeat for highpass 
h_hp = ftrans2(b_hp);     %trasnfrom filtro em 1 dimensao num de 2: comando ftrans2
I_highpass = imfilter(I, h_hp);
I_highpass = mat2gray(I_highpass); 
I_highpass_rep = imfilter(I,h_hp,'replicate');
I_highpass_rep = mat2gray(I_highpass_rep);
h_g = fspecial('gaussian',8,2);     % hsize = 8, sigma = 2
I_lowgauss = imfilter(I,h_g);       % Gaussian filter
%
%%
                   %Plot the images

figure;                          
subplot(2,3,1); imshow(I);
title('Original','FontSize',12);
subplot(2,3,2); imshow(I_lowpass);
title('Lowpass','FontSize',12);
subplot(2,3,3); imshow(I_lowgauss);
title('Gaussian Lowpass','FontSize',12);
subplot(2,3,4); imshow(I_highpass);
title('Highpass','FontSize',12);
subplot(2,3,5); imshow(im2bw(I_highpass,.44));
title('Highpass Thresholded');
subplot(2,3,6); imshow(im2bw(I_highpass_rep,.54));
title('Highpass Replicated Thresholded');
%
%%
          % Now plot the highpass and lowpass frequency characteristics
N = 128;
F= fftshift(abs(fft2(h_lp,N,N)));
figure; % lowpass  square window
mesh(1:N,1:N,F); colormap(hot); caxis([0 2]);
    title('Lowpass Filter','FontSize',14); view([-37,15]);
    %set the angle of the view from which an
    %observer sees the current 3-D plot.
    axis([0 N 0 N 0 1.2]);
    xlabel('Horizontal Frequency','FontSize',12); ylabel('Vertical Frequency','FontSize',12);
    zlabel('Magnitude','FontSize',12);
%
F = fftshift(abs(fft2(h_g,N,N)));
figure; % low pass gaussian
mesh(1:N,1:N,F); colormap(hot); caxis([0 2]);
    title('Gaussian Filter','FontSize',14); view([-37,15]);
    axis([0 N 0 N 0 1.2]);
    xlabel('Horizontal Frequency','FontSize',12); ylabel('Vertical Frequency','FontSize',12);
    zlabel('Magnitude','FontSize',12);
    %
F = fftshift(abs(fft2(h_hp,N,N)));
figure; % highpass square window
mesh(1:N,1:N,F); colormap(hot); caxis([0 2]);
    title('Highpass Filter','FontSize',14); view([-37,15]);
    axis([0 N 0 N 0 1.2]);
    xlabel('Horizontal Frequency','FontSize',12); ylabel('Vertical Frequency','FontSize',12);
    zlabel('Magnitude','FontSize',12);
    