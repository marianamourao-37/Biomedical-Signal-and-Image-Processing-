clear all; close all;
frame = 18;
[I, map] = imread('mri.tif', frame);
% [I(:,:,:,1), map] = imread('mri.tif', frame);
if isempty(map) == 0                  % Check to see if Indexed data
    I = ind2gray(I,map);              % If so, convert to Intensity image
else 
    I = im2double(I);                 % Convert to double and scale
end
[M N]= size(I);                     
%
% Define afine transformation
U1 = [N/2 1; 1 M; N M];             % Input triangle
X1 = [1 M/2; N M; N 1];               % Output triangle (rotação de 90º em sentido antihorario)
Tform1 = maketform('affine', U1, X1); %criaçao da estrutura para a transformacao, sendo esta afim (affine)
I_affine = imtransform(I,Tform1,'Size',[N,M]); %pretende-se dar a mesma dimensao 
figure(1);
subplot(2,1,1); imshow(I);       
    title('Original','FontSize',14);
subplot(2,1,2);  imshow(I_affine);
    title('Affine Transformation','FontSize',14);
%%
% Define projective transformation (foward, como se a folha caisse sobre)
% 
U = [1 1; 1 M; N M; N 1];
offset = .15*N; %offset de 15% do numero de pixeis do numero de colunas -> apontamentos 
%dos slides diz que se refere a tilt 
X = [1-offset 1+offset; 1+offset M-offset; N-offset M-offset; N+offset 1+offset]; 
Tform2 = maketform('projective', U, X);
I_proj1 = imtransform(I,Tform2,'Xdata',[1 N],'Ydata',[1 M]);
%
% Second transformation. Define new output quadrilateral (parte de cima
% afasta se da nossa vizta -> backward projection)
X = [1+offset 1+offset; 1-offset M-offset; N+offset M-offset; N-offset 1+offset]; 
Tform3 = maketform('projective', U, X);
I_proj2 = imtransform(I,Tform3,'Xdata',[1 N],'Ydata',[1 M]);
%
%Display the images
figure(1);
subplot(2,2,1); imshow(I);       
    title('Original','FontSize',14);
subplot(2,2,2);  imshow(I_affine);
    title('Affine Transformation','FontSize',14);
subplot(2,2,3); imshow(I_proj1);
    title('Projective Transformation forward','FontSize',14);
subplot(2,2,4); imshow(I_proj2);
    title('Projective Transformation backward','FontSize',14);