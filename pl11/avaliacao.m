clear all; close all;

I= im2double(rgb2gray(imread('knee.tiff')));

BW=~imbinarize(I,graythresh(I)); % Threshold and invert original image.  
% e negado para que a regiao de interesse fique a branco - pois os comandos
% imclose e imopen são sensiveis às regiões brancas. 

%% Erode+Dilate=Open
% Abertura da imagem
SE1=strel('disk',4);           % Define uma estrutura SE1 --> JULGO QUE O DISCO 
%NAO SE ADEQUA ÀS ESTRUTURAS A FECHAR E/OU ABRIR 
BW1=imerode(BW,SE1);           % Opening operation: erode image first,
BW2=imdilate(BW1,SE1);         % then dilate

% para realizar o mesmo procedimento podemos apenas usar o imopen
IM1=imopen(BW,SE1);

figure('Name', 'Open, Disk');
subplot(2,3,1); imshow(I);
title('Original Image','FontSize',12);

subplot(2,3,2); imshow(~BW); %yes, faz a negação da negação --> imagem nao invertida neste caso
title('Original Thresholded','FontSize',12);

subplot(2,3,3); imshow(BW); %BW corresponde a uma negação, daí dizer-se invertida 
title('Original Thresholded Inverted','FontSize',12);

subplot(2,3,4); imshow(BW1);
title('Eroded Inverted Image','FontSize',12); 

subplot(2,3,5);  imshow(BW2);
title('Opened Inverted Image','FontSize',12);

subplot(2,3,6); imshow(~BW2); %yes, para voltar à imagem original mas com regiões abertas 
title('Opened Image Noninverted','FontSize',12);

%% Dilate+Erode=Close
% Fecho da imagem
SE2=strel('disk',4);           % Define closing structure
BW3=imdilate(BW,SE2);          % Closing operation, dilate image first
BW4=imerode(BW3,SE2);          % then erode

% para realizar o mesmo procedimento podemos apenas usar o imclose
IM2=imclose(BW,SE2);

figure('Name', 'Close, Disk');
subplot(2,3,1); imshow(I);      % Use opened image
    title('Original Image','FontSize',12);
subplot(2,3,2); imshow(~BW);      % Use opened image
    title('Original Thresholded','FontSize',12);
subplot(2,3,3); imshow(BW);      % Use opened image
    title('Original Thresholded Inverted','FontSize',12);
subplot(2,3,4); imshow(BW3);
    title('Dilated Image Inverted','FontSize',12);
subplot(2,3,5);  imshow(BW4);
    title('Closed Image','FontSize',12);
subplot(2,3,6); imshow(~BW4);
   title('Closed Image Non-inverted','FontSize',12);

%% Direto, com linha
% line structer
SE=strel('line',10,45); 
IM1=imopen(BW,SE);
IM2=imclose(BW,SE);
figure('Name','Line - Open & Closed')
subplot(1,3,1); imshow(~BW); title('Original threshold inverted');
subplot(1,3,2); imshow(~IM1); title('Opened image');
subplot(1,3,3); imshow(~IM2); title('Closed image');

%% Direto, com Rectangulo
% rectangle struture
SE=strel('rectangle',[5 6]); 
IM1=imopen(BW,SE);
IM2=imclose(BW,SE);
figure('Name','Rectangle')
subplot(1,3,1); imshow(~BW); title('Original threshold inverted');
subplot(1,3,2); imshow(~IM1); title('Opened image');
subplot(1,3,3); imshow(~IM2); title('Closed image');

%% Direto, com esfera
% sphere structure
SE=strel('sphere',4); 
IM1=imopen(BW,SE);
IM2=imclose(BW,SE);
figure('Name','Sphere')
subplot(1,3,1); imshow(~BW); title('Original threshold inverted');
subplot(1,3,2); imshow(~IM1); title('Opened image');
subplot(1,3,3); imshow(~IM2); title('Closed image');