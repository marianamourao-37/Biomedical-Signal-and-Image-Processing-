function y=ex6_1_mylowpass(x,nord,wn)
B = fir1(nord, wn, rectwin(nord+1));
y=filter(B,1,x);
end 

%ter um roll-off o mais elevado possivel ao custo de alguns artefactos 