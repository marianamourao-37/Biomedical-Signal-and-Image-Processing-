% Cristiana Ernesto(48097), Mariana Mour�o (49963) 17 Mar 2019
% T3 - Exerc�cio de Avalia��o

% Programa que gera ru�do colorido de N larguras de banda diferentes e
% avalia a respetiva fun��o de autocorrela��o, assim como estabelece uma
% estimativa da rela��o entre a largura de banda do ru�do colorido e 
% a largura(FWHM) da sua fun��o de autocorrela��o. 


close all; clear all;
npts = 1024;        % Size of arrays
L = 100;			% FIR filter length (fun��o sinc(x) representada por 
%100 coeficientes no dom�nio temporal) 
noise = randn(npts,1);	% Generate noise

% Compute the impulse response of a low pass filter
% This type of filter is covered in Chapter 5
%
N=40; % Dimens�o ajust�vel do vetor wn.

wn = pi/N: pi/N :pi; % Vetor wn que cont�m frequ�ncias de corte igualmente 
%espa�adas por pi/N, normalizadas para [0,pi].

largura_rxx = zeros(N,1); % Vetor coluna que armazena para cada 
%frequ�ncia de corte a respetiva largura (FWHM) da fun��o de autocorrela��o

t=1; % Vari�vel de modo a gerar 4 subplots numa matriz 2x2

for k = 1:N				% Repeat for two different frequencies
   wc = wn(k);
   for i = 1:L+1	% Generate sin(x)/x function
   	n = i-L/2-1;    % Make symmetrical, -1 addded by pcmiranda
   	if n == 0       % C�lculo particular para n=0, pois tem uma singularidade 
      	hn(i) = wc/pi;
   	else   
   		hn(i) = (wc/pi)*sin(wc*n)/(wc*n); %Filter impulse response
        % normalization of sinc function now explicit, pcmiranda. Caso
        % geral para quando n�o existe singularidade 
    end
   end 
   out = conv(hn,noise);	% Output - noise after filtering
   
   % Calculate autocorrelation with zero lag normalized to 1
   [cor,lags] = xcorr(out,'coeff');
   
   maximo = max(cor); % � igual a 1 devido � normaliza��o realizada pelo 
   %par�metro 'coeff', correspondendo ao momento em que os sinais est�o em 
   %fase.
   
   abovehalfmax = cor>maximo/2; % Find where it's more than half the max. 
   %(=0.5 em consequ�ncia da linha anterior)
   
  
   % Pontos imediatamente antes e depois de cor=0.5: 
   lastindex = find(abovehalfmax, 1, 'last'); % �ndice do �ltimo valor 
   %cor>0.5, ou seja, imediatamente antes de cor=0.5
   index2 = lastindex+1; % �ndice imediatamente depois do �ltimo �ndice 
   %correspondente a cor>0.5
   
   % Obten��o da reta de regress�o linear tendo em conta os pontos
   %[cor(lastindex),lags(lastindex)] e [cor(index2), lags(index2)]:
   [~,m,b]=regression([lags(lastindex) lags(index2)],[cor(lastindex) cor(index2)]);
   % Obt�m-se o declive m e a ordenada na origem b, para o posterior 
   % c�lculo dos �ndices interpolados que correspondem a cor=0.5. 
   
   % Interpola��o por regress�o linear tendo em conta que a equa��o da
   %reta obtida � cor=m*lags + b. Pretende-se saber o valor 
   %interpolado por regress�o linear do �ndice para o qual cor=0,5:  
   lags_interpolacao = (0.5 - b)/m;
   
   largura_rxx(k,1)= 2*lags_interpolacao; % Devido � simetria da fun��o 
   %de autocorrela��o
   
   if wc==wn(2) | wc==wn(6)  % Gerar 4 subplots relativos a duas wc, 
       %dois para a representa��o temporal do ru�do e dois para a fun��o de 
       %autocorrela��o
   
       subplot(2,2,2*t-1), plot(out);
       axis([1 npts -max(abs(out)) max(abs(out))]);
       xlabel('Amostra');
       ylabel('Ru�do Colorido');
       title(['Largura de banda = ', num2str(wc)]); % Describe bandwidth
       
       subplot(2,2,2*t); 
       plot(lags(1,:),cor(:,1),'kx-');	% Plot autocorrelation function
       grid on;
       axis([-L/2 L/2 -.5 1.1]);  
       xlabel('Lags (amostras)');
       ylabel('Rxx');
       title(['Largura de banda = ', num2str(wc)]);
       hold on;
       % Linhas que evidenciam graficamente a largura da fun��o de
       %autocorrela��o a partir do ponto interpolado (linha azul) e a
       %partir dos pontos usados na interpola��o (linhas tracejadas):
       line([-lags_interpolacao lags_interpolacao -lags_interpolacao;  -lags_interpolacao lags_interpolacao lags_interpolacao], [-maximo/2 -maximo/2 maximo/2; maximo/2 maximo/2 maximo/2], 'Color', 'b', 'LineWidth', 1);
       line([-lags(lastindex) lags(lastindex) -lags(lastindex);  -lags(lastindex) lags(lastindex) lags(lastindex)],[-cor(lastindex) -cor(lastindex) cor(lastindex); cor(lastindex) cor(lastindex) cor(lastindex)], 'Color', 'r', 'LineWidth', 0.5, 'LineStyle', '--');
       line([-lags(index2) lags(index2) -lags(index2);  -lags(index2) lags(index2) lags(index2)], [-cor(index2) -cor(index2) cor(index2); cor(index2) cor(index2) cor(index2)], 'Color', 'm', 'LineWidth', 0.5, 'LineStyle', '--');
       
       %texto a adicionar aos gr�ficos da fun��o de autocorrela��o,
       %explicitando-se o valor da FWHM com e sem interpola��o:
       text(-48,0.9,['FWHM=', num2str(2*lags_interpolacao)],'Color','b','FontSize',7); %FWHM interpolada
       text(-48,0.75,['FWHM=', num2str(2*lags(lastindex))],'Color','r','FontSize',7);
       text(-48,0.6,['FWHM=', num2str(2*lags(index2))],'Color','m','FontSize',7);
       
       t=t+1;
   end

end

figure(2)
plot(wn,largura_rxx,'r*-');% Gr�fico da largura da fun��o de autocorrela��o 
%em fun��o da largura de banda do ru�do colorido. 
xlabel('Largura de banda do ru�do colorido (rad/amostra)');
ylabel('Largura de Rxx (FWHM)');
title('Largura da fun��o de autocorrela��o em fun��o da largura de banda');
