clear all; close all;
frame = 18;                     % Desired frame number
H_scale = .25;                  % Re-scale dimension in percent, scale(1).  muda a escala em 25%
V_scale = .2;                   % Re-scale dimension in percent, scale(2)
tilt = .2;                      % tilt in percent, scale(3) -> corresponde a um shear (e nao a uma rotacao)
[I, map ] = imread('mri.tif', frame); %imagem tif tem varias imagens la dentro e vai ser a 
%18 imagem que lá está 
% [I(:,:,:,1), map ] = imread('mri.tif', frame);
if isempty(map) == 0            % Check to see if Indexed data
    I = ind2gray(I,map);        % If so, convert to Intensity image
else 
    I = im2double(I);           % Convert to double and scale
end
[M N]= size(I); 
%passagem dos numeros para pixels:
H_scale = H_scale * N/2;          % Convert percent rescale to pixels  (muda nos dois lados da imagem)
%N/2 pois aumenta para a esuqreda e para a direita 
V_scale = V_scale * M; %so aplica num dos lados da image na escala vertical)
tilt = tilt * N; %20% da largura N da imagem. 
%
% Construct distorted image.
U = [1 1; 1 M; N M];          % Input triangle, affine transformation

X = [1-H_scale+tilt 1+V_scale; 1-H_scale M; N+H_scale M];  % Output triangle
%imagem encolhe na horizontal

Tform = maketform('affine', U, X);
I_transform = (imtransform(I,Tform,'bicubic','Xdata',[1 N],'Ydata',[1 M]));
%imagem deformada para a direita, e foi aumentada na horizontal e diminuida
%na vertical 

% 
% Now find transformation to relign image: calcular os valores para a partir 
%desta imagem se conseguir trasnformar para a original (função de minimização)
initial_scale = [1 1 1];        % Set initial values
[scale,FVAL,error] = fminsearch('realign',initial_scale,[],I, I_transform);
%valores iniciais para os varios parametros para a função que minimiza: inicial_scale 
%calcular a trasnformação que defaz a distorção entre I, I_transform -> inputs para a função realign

% [] is the place holder for options. It is followed by additional
% parameters for the function (realign in this case)
disp(FVAL)                  % Display final correlation
%
% Realign image using optimized scaling; após obtidos os fatores de escala,
% pode se proceder à transfromação 
%scale(1) -> scale horizontal 
%scale(2) -> scale vertical 
%scale(3) -> scale tilt 

X = [1+scale(1)+scale(3) 1+scale(2); 1+scale(1) M; N-scale(1) M]; %novo vetor 
%X para fazer a transformação para converter para imagem original 
Tform = maketform('affine', U, X);
I_aligned = imtransform(I_transform,Tform,'bicubic','Xdata',[1 N],'Ydata',[1 M]);
%
subplot(1,3,1); imshow(I);       %Display the shifted image
    title('Reference Image','FontSize',12);
subplot(1,3,2); imshow(I_transform);
    title('Input Image','FontSize',12);
subplot(1,3,3);  imshow(I_aligned);
    title('Aligned Image','FontSize',12);   