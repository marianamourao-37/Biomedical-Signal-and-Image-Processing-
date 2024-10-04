clear all; close all;
[I map] = imread('hestain.png');     % Input image 
if isempty(map) == 0                 % Check to see if Indexed data
    I = ind2gray(I,map);             % If so, convert to Intensity image
end 
I = im2double(rgb2gray(I));          % Convert to double and scale (se nao for imagem indexada)

%deixa de fora as imagens de intensidade 
    %
% Rotate image with and without cropping

[M N] = size(I); %dimensoes da imagem

figure(1);
subplot(2,2,1);imshow(I); title('Original','FontSize',14);
figure(2);
subplot(2,2,1);imshow(I); title('Original','FontSize',14);
figure(3);
subplot(2,2,1);imshow(I); title('Original','FontSize',14);
interpolacao = ["nearest","bilinear","bicubic"];
for i=1:length(interpolacao)
    I_rotate_nc = imrotate(I,-45,interpolacao(i));   % Rotation, direação dos 
%ponteiros do relogio (-)
    I_rotate_c = imrotate(I,-45,interpolacao(i),'crop'); 
    figure(1);
    subplot(2,2,i+1);imshow(I_rotate_nc);title([interpolacao(i),'rotate']); 
    
    figure(2); 
    subplot(2,2,i+1);imshow(I_rotate_c);title([interpolacao(i),'rotate~cropped']); 
    
    figure(3);
    I_stretch = imresize(I,[M N*1.25], interpolacao(i));
    subplot(2,2,i+1);imshow(I_stretch); title([interpolacao(i),'Horizontal Stretch']);
end 

%nearest -> aspeto mais granulado 
%linear e cubica -> variacçao mais lenta da intensidade da imagem

%opção crop, mostrando 
%imagem rodada mas cuja boundary box é do mesmo tamanho do que a 
%original (a imagem de interesse fica cortada)