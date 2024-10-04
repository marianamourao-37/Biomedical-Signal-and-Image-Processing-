%Exercicio avaliação
%TP9

Ler=im2double(rgb2gray(imread('Brain.bmp')));


img=padarray(Ler,[0 1],'post');
TF=(fft2(img));          %Transformada de fourier
f=10;                     %Fator multiplicativo para aumentar a intensidade

shift1=fftshift(TF);


for a= 200:300       %Linhas do espetro 
    shift1(a,:)=f*shift1(a,:);
end

reverse=fftshift(shift1);
img_denovo=(ifft2(reverse));

figure(1); 
subplot(2,2,1); imshow(Ler); title('Imagem original');
subplot(2,2,2); imshow(mat2gray(20*log10(abs(TF)))); title('TFourier');
subplot(2,2,3); imshow(mat2gray(20*log10(abs(shift1)))); title('fftshift');
subplot(2,2,4); imshow(img_denovo); title('Intensidade aumentada');
subplot(2,2,1); ylabel('Vertical Frequency','FontSize',14);
subplot(2,2,3); xlabel('Horizontal Frequency','FontSize',14);
