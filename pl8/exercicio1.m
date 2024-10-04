clear, close all;

imagem = zeros(8,12);
imagem(3:5,6:10) = 1; 

imwrite(imagem,'retangulo_exercicio1.bmp')
imagem_lida = imread('retangulo_exercicio1.bmp'); 
figure(1);
imshow(imagem_lida); 

%%
clear, close all; 
f = 3; %frequencia 3 
N= 100; %100 pontos
x = (1:N)/N; %x é uma coordenada espacial (contando se de 1 a 100 a dividir
%por 100, contando de 1/100 de 1 a 100)
y = sin(2*pi*f*x); %intensidade que varia sinusoidalmente; seno vai de -1
%a +1, sendo que a gama que se pretende utilizar vai de 0 a 1 
ynorm = (y-min(y))/(max(y)-min(y)); %subtrai se -1 (y(min)), sendo que o
%sen varia de 0 a 2, sendo que depois normaliza se: max(y)-min(y) = 2 
I = repmat(ynorm,N,1); %repete se o padrao sinusoidal em N linhas (ficando
%se com uma imagem 100 por 100, reoetindo se nas linhas e nao nas colunas) 
figure(2); 
surf(I); %comando surf e nao imshow, para ver que é sinusoidal 
imwrite(I,'mypic.bmp','bmp'); 
I1 = imread('mypic.bmp'); 
figure(3); 
imshow(I1); %imagem de intensidades, pois tem valores entre 0 a 1, assumindo 
%igualmente valores intermédios
figure(4);
surf(im2double(I1)); %surf so trabalha com doubles 

%%
N= 100;
x = rand(N);
I = repmat(x,[10 10]);
%B = repmat(A,M,N) or B = repmat(A,[M,N]) creates a large matrix B 
%    consisting of an M-by-N tiling of copies of A. If A is a matrix, 
%    the size of B is [size(A,1)*M, size(A,2)*N].
figure(5)
subplot(2,1,1),imshow(I)
title('Imagem criada com repmat')
imwrite(I,'None','png');
imagemlida = imread('None');
subplot(2,1,2), imshow(imagemlida)
title('Imagem lida')