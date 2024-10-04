clear, close all;

%INFO = imfinfo('http://www.biomedimaging.org/BookImages/mammogram.tif');
Image = imread('http://www.biomedimaging.org/BookImages/glomeruli.tif'); % RGB Matrix 
Gray_Image = rgb2gray(Image);           % Grayscaled image
Doubled_Image = im2double(Gray_Image);  % Matrix of doubles 

% Create vectors with x,y spatial coordinates (not pixels coordinates)
xdim = size(Doubled_Image,2);
ydim = size(Doubled_Image,1);
X = (1:xdim);   % Row vector
Y = (1:ydim)';  % Column vector

scale = [0.3,3];  % scale < 1 corresponds to downsampling
metodos = ["nearest neighbor","spline","cubic","linear"];
figure(1);
subplot(3,1,1); imshow(Doubled_Image); title('Original Image');

figure(2);
subplot(3,1,1); imshow(Doubled_Image); title('Original Image');

figure(3);
subplot(3,1,1); linha_media = Doubled_Image(fix(ydim/2),:); plot(linha_media); 
title('Original graphic at line 265');
title('Perfil de Intensidades: Original');
xlabel('Colunas'); ylabel('Intensidade');
grid on

figure(4);
subplot(3,1,1); linha_media = Doubled_Image(fix(ydim/2),:); plot(linha_media); 
title('Original graphic at line 265');
title('Perfil de Intensidades: Original');
xlabel('Colunas'); ylabel('Intensidade');
grid on

figure(7);
subplot(1,3,1); imshow(Doubled_Image); title('Original Image');

for i=1:length(scale)
    Xq = 1:1/scale(i):xdim;   
    Yq = (1:1/scale(i):ydim)';
    for j=1:length(metodos)
        D_dn = interp2(X,Y,Doubled_Image,Xq,Yq, metodos(j));
        figure(i);
        subplot(3,2,2+j); imshow(D_dn); zoom(4); 
        title([metodos(j),' interpolation',';factor scale = ',num2str(scale(i))]); 
        
        figure(i+2);
        subplot(2,1,2); linha_media = D_dn(fix(length(Yq)/2),:); plot(linha_media); 
        title('Graphics at line 80'); hold on;
        xlabel('Colunas'); ylabel('Intensidade');
        grid on
        
        figure(i+4);
        subplot(1,1,1),plot(linha_media); title('Closer look (Zoomed in)'); hold on;
        xlabel('Colunas'); ylabel('Intensidade');
        grid on
        xlim([48,68]);
        
    figure(7);
    subplot(1,3,i+1); imshow(D_dn); title(['Resamplig by a factor scale = ',num2str(scale(i))]);  
    end 
end 

figure(3);
subplot(2,1,2);
legend('Nearest', 'Spline', 'Cubic','Linear (Default)');

figure(4);
subplot(2,1,2);
legend('Nearest', 'Spline', 'Cubic','Linear (Default)');

figure(5);
subplot(1,1,1);
legend('Nearest', 'Spline', 'Cubic','Linear (Default)');

figure(6);
subplot(1,1,1);
legend('Nearest', 'Spline', 'Cubic','Linear (Default)');
