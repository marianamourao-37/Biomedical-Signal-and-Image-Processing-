close, clear all;

imagem = imread('Brain.bmp');
info = imfinfo('Brain.bmp');
I = im2double(rgb2gray(imagem)); 

graybrain = padarray(I,[0 1],'post');

figure(1)
subplot(1,3,1);imshow(graybrain);
title('brain');
%plot FFT
fft_b = fft2(graybrain);
fft_b_DB = 20*log10(abs(fftshift(fft_b)));
fft_b_DB = mat2gray(fft_b_DB);
subplot(1,3,2);imshow(fft_b_DB);
title('FFT of brain'); 
%apply inverse FFT 
brainagain = ifft2(fft_b);
subplot(1,3,3);imshow(brainagain);
title('iFFT of FFT of brain');

% Show that two consecutive applications of fftshift returns the original
% matrix
figure(2);
subplot(1,4,1); imshow(graybrain);
title('brain');
subplot(1,4,2); imshow(fftshift(graybrain));
title('fftshift(brain)');
subplot(1,4,3); imshow(fftshift(fftshift(graybrain)));
title('fftshift(fftshift(graybrain))');
subplot(1,4,4); imshow(fftshift(fftshift(graybrain))- graybrain);
title('fftshift(fftshift(graybrain)) - graybrain');

%create mask to keep low frequencies 
figure(3);
shiftedmask = roipoly(fft_b_DB);
subplot(2,3,1);imshow(shiftedmask.*fft_b_DB);
title('LF masked FFT - shifted');
%work with unshifted mask and unshifted fft2 
mask = fftshift(shiftedmask);
%low frequency filter 
subplot(2,3,2);imshow(mask);
title('LF mask - unshifted'); 
lfmasked_fft = mask.*fft_b;   %AQUI NAO SE TEM O ABSOLUTO!!
lfbrain = ifft2(lfmasked_fft); %porque é que o prof faz absoluto????
subplot(2,3,3);imshow(lfbrain); 
title('iFFT of LF masked FFT'); 
%high frequency filter 
subplot(2,3,4);imshow(~shiftedmask.*fft_b_DB);
title('HF masked FFT shifted');
subplot(2,3,5);imshow(~mask);
title('HF mask - unshifted');
hfmasked_fft = ~mask.*fft_b; 
subplot(2,3,6);imshow(ifft2(hfmasked_fft));
title('iFFT of HF masked FFT');
