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
 
% Define afine transformation - 90º Rotation (ACW)
U1 = [1 1; 1 M; N M];             % Input triangle
X1 = [1 M; N M; N 1];             % Output triangle
% Basta trocar os vertices no triangulo do output para definirmos a rotação
% pretendida, neste caso de 90º
Tform1 = maketform('affine', U1, X1);
I_affine1 = imtransform(I,Tform1,'Size',[N,M]);

% Define afine transformation - 90º Rotation (CW)
X = [N 1; 1 1; 1 M];             % Output triangle
Tform1 = maketform('affine', U1, X);
I_affine2 = imtransform(I,Tform1,'Size',[N,M]);

%Display the images
figure(1);
subplot(1,3,1); imshow(I);       
    title('Original','FontSize',14);
subplot(1,3,2);  imshow(I_affine1);
    title('Affine Transformation','FontSize',14);
subplot(1,3,3); imshow(I_affine2);
    title('Projective Transformation forward','FontSize',14);