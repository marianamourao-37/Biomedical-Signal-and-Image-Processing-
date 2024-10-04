% EXERCÍCIO DE AVALIAÇÃO PL8
% Daniel Silva & Ema Lopes

clear, close all;

A=imread('http://www.biomedimaging.org/BookImages/glomeruli.tif');
G=rgb2gray(A);
D=im2double(G);

%Create vectors with x,y spatial coordinates (not pixels coordinates)
xdim=size(D,2); % 2 representa a segunda dimensão mxn
ydim=size(D,1);
X=1:xdim;
Y=(1:ydim)'; % ' porque Y é uma coluna e não um vetor

%Create vectors with resampling spatial coordinates
%The numbers of pixels in the final image is approximately equal to the
%numbers in the original image multiplied by a scale factor

%% DOWNSAMPLING 

scale1 = 0.3; % scale < 1 corresponds to downsampling
Xq1=1:1/scale1:xdim;
Yq1=(1:1/scale1:ydim)';

% As várias interpolações em downsampling
D_dn_linear = interp2(X,Y,D,Xq1,Yq1,'linear');
D_dn_near = interp2(X,Y,D,Xq1,Yq1,'nearest');
D_dn_spl = interp2(X,Y,D,Xq1,Yq1,'spline');
D_dn_cubic = interp2(X,Y,D,Xq1,Yq1,'cubic');

% De seguida encontra-se o código que permite mostrar a imagem original e a
% mesma com zoom para se visionar melhor a pixelização, bem como as
% restantes interpolações pelos diferentes métodos, igualmente com zoom.

figure('Name','Zoomed Original Image and Zoomed Downsampled Images');
subplot(2,3,1); imshow(D); title('Original Imagem');
subplot(2,3,4); imshow(D); zoom(4); title('Original Zoomed Imagem');
subplot(2,3,2); imshow(D_dn_linear); zoom(4); title('Downsampling - Linear');
subplot(2,3,3); imshow(D_dn_near); zoom(4); title('Downsampling - Nearest');
subplot(2,3,5); imshow(D_dn_spl); zoom(4); title('Downsampling - Spline');
subplot(2,3,6); imshow(D_dn_cubic); zoom(4); title('Downsampling Image - Cubic');

%% UPSAMPLING

scale2 = 1/scale1; % scale > 1 corresponds to upsampling
Xq2=1:1/scale2:xdim;
Yq2=(1:1/scale2:ydim)';

% As várias interpolações em upsampling
D_up_linear = interp2(X,Y,D,Xq2,Yq2,'linear');
D_up_near = interp2(X,Y,D,Xq2,Yq2,'nearest');
D_up_spl = interp2(X,Y,D,Xq2,Yq2,'spline');
D_up_cubic = interp2(X,Y,D,Xq2,Yq2,'cubic');

% À semelhança com o downsampling, de seguida encontra-se o código que 
% permite mostrar a imagem original e a mesma com zoom para se visionar 
% melhor a pixelização, bem como as restantes interpolações em upsmapling 
% pelos diferentes métodos, igualmente com zoom.

figure('Name','Zoomed Original Image and Zoomed Upsampling Images');
subplot(2,3,1); imshow(D); title('Original Imagem');
subplot(2,3,4); imshow(D); zoom(4); title('Original Zoomed Imagem');
subplot(2,3,2); imshow(D_up_linear); zoom(4); title('Upsampling - Linear');
subplot(2,3,3); imshow(D_up_near); zoom(4); title('Upsampling - Nearest');
subplot(2,3,5); imshow(D_up_spl); zoom(4); title('Upsampling - Spline');
subplot(2,3,6); imshow(D_up_cubic); zoom(4); title('Upsampling - Cubic');

%% PERFIL DE INTENSIDADES!! CENTERLINES

%Escolher a linha central para comparar o perfil de intensidades da imagem original
%com o das imagens processadas

%Centerlines index
centerline=round(median(1:length(D)));%original
centerline_up=round(median(1:length(D_up_linear))); %upsampling
centerline_dn=round(median(1:length(D_dn_linear))); %downsampling

% Todas as matrizes das imagens em upsampling têm a mesma dimensão, mesmo o
% método sendo diferente, o mesmo acontece para downsampling

%% PERFIL DE INTENSIDADES - DOWNSAMPLING

figure('Name','Perfil de Intensidades - Downsampling na linha central');
% Perfil da linha central na imagem original
subplot(2,2,1); plot(D(centerline,:),'.-');
legend('Original');
title('Perfil de Intensidades: Original');
xlabel('Colunas'); ylabel('Intensidade');
grid on
%Perfil da linha central nas imagens de downsampling
subplot(2,2,3); plot(D_dn_linear(centerline_dn,:),'.-'); hold on
plot(D_dn_near(centerline_dn,:),'.-'); hold on 
plot(D_dn_spl(centerline_dn,:),'.-'); hold on 
plot(D_dn_cubic(centerline_dn,:),'.-');
legend('Linear','Nearest','Spline','Cubic');
title('Perfil de Intensidades: Downsampling');
xlabel('Colunas'); ylabel('Intensidade');
grid on
    
% De maneira a comparar melhor o perfil de intensidades escolhe-se um
% região de interesse, neste caso certas colunas onde o perfil corresponde
% à mesma região da imagem

subplot(2,2,2); plot(D(centerline,:),'.-');
legend('Original');
title('Perfil de Intensidades: Original (Zoom entre a coluna 156 e a 223)');
xlabel('Colunas'); ylabel('Intensidade');
xlim([156,223]);
grid on

subplot(2,2,4); plot(D_dn_linear(centerline_dn,:),'.-'); hold on
plot(D_dn_near(centerline_dn,:),'.-'); hold on 
plot(D_dn_spl(centerline_dn,:),'.-'); hold on 
plot(D_dn_cubic(centerline_dn,:),'.-');
legend('Linear','Nearest','Spline','Cubic');
title('Perfil de Intensidades: Downsampling (Zoom entre a coluna 48 e a 68)');
xlabel('Colunas'); ylabel('Intensidade');
xlim([48,68]);
grid on

%% PERFIL DE INTENSIDADES - UPSAMPLING 
% Aqui tudo é feito à semelhança do feito anteriormente para o downsampling

figure('Name','Perfil de Intensidades - Upsampling na linha central');

subplot(2,2,1); plot(D(centerline,:),'.-');legend('Original');
title('Intensity Profile: Original');
xlabel('Colunas');
ylabel('Intensidade');
grid on

subplot(2,2,3); plot(D_up_linear(centerline_up,:),'.-'); hold on
plot(D_up_near(centerline_up,:),'.-'); hold on 
plot(D_up_spl(centerline_up,:),'.-'); hold on 
plot(D_up_cubic(centerline_up,:),'.-');
legend( 'Linear','Nearest','Spline','Cubic');
title('Perfil de Intensidades: Upsampling');
xlabel('Colunas'); ylabel('Intensidade');
grid on

% Regiões de interesse

subplot(2,2,2); plot(D(centerline,:),'.-');
legend('Original');
title('Perfil de Intensidades: Original (Zoom entre a coluna 156 e a 223)');
xlabel('Colunas'); ylabel('Intensidade');
xlim([156,223]);
grid on

subplot(2,2,4); plot(D_up_linear(centerline_up,:),'.-'); hold on
plot(D_up_near(centerline_up,:),'.-'); hold on 
plot(D_up_spl(centerline_up,:),'.-'); hold on 
plot(D_up_cubic(centerline_up,:),'.-');
legend( 'Linear','Nearest','Spline','Cubic');
title('Perfil de Intensidades: Upsampling (Zoom entre a coluna 515 e a 744)');
xlabel('Colunas'); ylabel('Intensidade');
xlim([515,744]);
grid on