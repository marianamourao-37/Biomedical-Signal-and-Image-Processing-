imagem = imread('knee.tiff');
I = rgb2gray(imagem);
I = im2double(I);
imhist(I);

threshold = input('escolha um thershold que maximize a variancia interclasse: '); 

I_binarizada = imbinarize(I,threshold); 

imshow(I_binarizada);
