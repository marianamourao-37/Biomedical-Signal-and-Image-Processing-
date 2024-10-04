clear all; close all;
I = imread('blood1.tif');
I = im2double(I);
BW = ~im2bw(I,graythresh(I));        % Threshold and invert original image. 
%faz se isto pois as c�lulas sao escuras, e erose, dilate, close e open estao 
%relacionadas com as zonas mais claras da imagem 
%como era inicialmente uma imagem bin�ria basta fazer a nega��o, senao
%tinha se de utilizar o imcomplement
estruturas = ["square","disk","diamond"];

u = 1;
for j = 1:2:10
    for i=1:length(estruturas)
        SE1 = strel(estruturas(i),j);           % Define structure: disk of radius 4 pixels
        BW1 = imerode(BW,SE1);           % Opening operation: erode image first,
        BW2 = imdilate(BW1,SE1);         % then dilate: foram removidos pequenos 
%artefactos (pequenos pontos)
%existiam artefactos bracos ap�s nega��o da imagem que froam removidos por 
%erose (usado structered ekement com maior dimensao podia se destruir parte 
%da imagem que se interessa preservar
        figure(u)
        subplot(2,3,1); imshow(I);
        title('Original Image','FontSize',12);
        subplot(2,3,2); imshow(~BW);
        title('Original Thresholded','FontSize',12);
        subplot(2,3,3); imshow(BW);
        title('Original Thresholded Inverted','FontSize',12);
        subplot(2,3,4); imshow(BW1);
        title(['Eroded Inverted Image',estruturas(i),'e dim = ', j],'FontSize',12);
        subplot(2,3,5);  imshow(BW2);
        title('Opened Inverted Image','FontSize',12); %j� depois da dilata��o aplicada ap�s eros�o 
        subplot(2,3,6); imshow(~BW2);
        title('Opened Image Noninverted','FontSize',12);
        u = u+ 1;
    end
end 

SE2 = strel('line',6,0);           % Define closing structure: disk radius 4 pixels
BW3 = imdilate(BW,SE2); % Closing operation, dilate image first
%c�lulas crescem, e as que nao se tcavam passam a ocar 
BW4 = imerode(BW3,SE2);          % then erode -> corresponde a fazer image close (imclose)
%pequenos artefactos nao foram removidos e criou se liga��o entre c�lulas 
%(pequenos gaps) -> O FECHAR � SEMPRE DA REGI�O EM CLARO -> FECHA O ESPA�O 
%ENTRE C�LULAS (APENAS SE SE UTILIZAR NESTE CASO O COMPLEMENTAR DA IMAGEM 
%INICIAL, EM QUE AS C�LULAS ERAM MAIS ESCURAS)
%
figure;
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