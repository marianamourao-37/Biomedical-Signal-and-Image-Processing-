% Processamento de Sinal e Imagens Biom�dicas
% T10 Exercicio de Avalia��o - Dete��o de fronteiras. Segmenta��o
% Mariana Mour�o n�49963

% Programa que procede � segmenta��o duma imagem imagem m�dica 
% ('glomeruli.bmp'), pela aplica��o de filtros de dete��o de fronteiras 
% (Roberts, Sobel, Canny e LoG) e posterior remo��o das mesmas (boundary
% masking), apresentando-se os respetivos histogramas. 
% Aplica��o do threshold �timo (m�todo de Otsu) � imagem antes e ap�s 
% boundary masking. 

%%
% sec��o que produz a figura que apresenta os subplots relativos � imagem 
% original, ao seu histograma de intensidades, bem como a imagem ap�s 
% segmenta��o pelo m�todo de otsu antes de boundary masking

clear, close all; 
INFO = imfinfo('glomeruli.bmp'); %imagem em causa � truecolor (RGB)
I = imread('glomeruli.bmp'); 
I = rgb2gray(I); %convers�o para matriz de intensidades.
I = im2double(I); % convers�o para double

% contru��o do filtros passa-alto a serem aplicados para a dete��o de
% fronteiras (LoG, Canny, Prewitt e Roberts). 

t1 = graythresh(I); %aplica��o do m�todo de Otsu � imagem original 

fig1 = figure(1);
set(fig1,'Name','Intensity Histogram and image before and after LowPass Filtered');
subplot(2,1,1), imshow(I); title('Original Image');
subplot(2,2,3),imshow(imbinarize(I,t1)),title(['Otsu Method with threshold = ',num2str(t1)],'FontSize',10);
subplot(2,2,4),imhist(I); title('Original Image histogram','FontSize',10); 
line([t1; t1],[0;700], 'Color', 'b', 'LineWidth', 1, 'LineStyle', '--'); 
%linha que evidencia o threshold de intensidade no histograma de intensidades 
%da imagem original

%%
% sec��o a ser executada duas vezes, para cada um dos thresholds

%escolha pelo utilizador dos thresholds quer para os filtros que aproximam
%derivadas de 1�ordem, como os que aproximam derivadas de 2�ordem:
thresh_1derivative = input('Choose a threshold value for 1st derivative filters (or type [] for default): ');
thresh_2derivative = input('Choose a threshold value for LoG filter (or type [] for default): ');

fig2 = figure(2); %cria��o da figura 2, a ser chamada no ciclo for que se segue
set(fig2,'Name','Binarize Image of edge fiddings and Image after Edge Removal');
sup = suptitle(['Threshold of 1st derivative filters = ',num2str(thresh_1derivative),'; Threshold of 2nd derivative filters = ', num2str(thresh_2derivative)]);
set(sup, 'FontSize',10); %t�tulo que especifica os thresholds definidos 

fig3 = figure(3); %cria��o da figura 3, a ser chamada no ciclo for que se segue
set(fig3,'Name','Image and Histograms after Edge Removal');

original_hist = imhist(I); %vari�vel necess�ria para o c�lculo do n�mero de 
%pixels de intensidade nula na imagem original 

metodos = ["roberts","sobel","LoG","canny"]; %array que define os m�todos a serem testados

u = 1; %vari�vel para a correta posi��o dos subplots nas respetivas figuras

for i=1:length(metodos)
    if metodos(i) == "LoG" % distin��o do c�digo para o filtro LoG, visto 
        %o seu valor threshold nao ser compar�vel aos restantes filtros 
        %(relativo a zero-crossigs)
        [I_edge,thresh1] = edge(I,'LoG',thresh_2derivative); %obten��o da 
        %imagem bin�ria das fronteiras, com thresh1 como sendo
        %o threshold definido pelo utilizador, destinado a ser escrito no
        %respetivo subplot do histograma
        
    else 
        [I_edge,thresh1] = edge(I,metodos(i),thresh_1derivative); 
        %obten��o da imagem bin�ria das fronteiras, com thresh1 como sendo
        %o threshold definido pelo utilizador, destinado a ser escrito no
        %respetivo subplot do histograma
        
    end 
    
    [~,thresh_default] = edge(I,metodos(i)); %obten��o do threshold 
    % determinado por default 
    
    I_rem = I .* imcomplement(I_edge); %aplica��o da m�scara � imagem original 
    %(boundary masking)
    t2 = graythresh(I_rem); %threshold determinado pelo m�todo de Otsu, 
    %ap�s boundary masking 
    
    figure(2);
    subplot(2,4,u),imshow(I_edge), title ([metodos(i),' Edge'],'FontSize',10); hold on; 
    %imagem bin�ria das fronteiras
    
    subplot(2,4,u+1); imshow(I_rem); title([metodos(i),' Edge Removed'],'FontSize',10); hold on; 
    %imagem ap�s boundary masking 
    
    figure(3);
    subplot(2,4,u);imshow(imbinarize(I,t2)); title(['Threshold Masked Image by Otsu Method: ',num2str(t2)],'FontSize',8); hold on;
    %segmenta��o pelo m�todo de Otsu, ap�s boundary masking
    
    %histograma ap�s boundary masking: 
    subplot(2,4,u+1); imhist(I_rem); title([metodos(i),' Edge Removed histogram'],'FontSize',8); hold on;
    line([t2; t2],[0;700], 'Color', 'b', 'LineWidth', 1, 'LineStyle', '--'); 
    %linhha tracejada que evidencia no histograma a separa��o se classes
    %pelo m�todo de Otsu
    axis([0 1 0 1800]); %defini��o da escala do histograma 
    
    edge_hist=imhist(I_rem); %vari�vel necess�ria para o c�lculo do n�mero de 
    %pixels de intensidade nula na imagem ap�s boundary masking 
    
    variation_zero_intensity = edge_hist(1)- original_hist(1); %c�lculo da 
    %varia��o do n�mero de pixels de intensidade nula antes e ap�s 
    %boundary masking (pixels detetados como pertencentes a fronteiras)
    
    text(0.02,1300,['added zero-intensity pixels = ',num2str(variation_zero_intensity)],'Color','k','FontSize',7.5);
    %respetivo texto que evidencia os pixels detetados como pertencentes a
    %fronteiras 
    
    %textos relativos aos thresholds definidos pelo utilizador e os
    %definidos por default: 
     if length(thresh1) > 1 %caso especifico do filtro canny, que apresenta 
        %um low-threshold e um high-threshold
        text(0.02,1700,['default edge thresholds = ', num2str(thresh_default(1)),'; ',num2str(thresh_default(2))],'Color','k','FontSize',7.5);
        text(0.02,1500,['set edge thresholds = ', num2str(thresh1(1)),'; ',num2str(thresh1(2))],'Color','k','FontSize',7.5);
        
    else 
        text(0.02,1700,['default edge threshold = ', num2str(thresh_default)],'Color','k','FontSize',7.5);
        text(0.02,1500,['set edge threshold = ', num2str(thresh1)],'Color','k','FontSize',7.5);
    end
    
    u = u + 2; %atualiza��o da vari�vel para a correta posi��o dos subplots 
    %nas respetivas figuras
end 