function brf=genbrfil;
% function brf=genbrf;
% TP estimation spectrale
% génération d'un bruit blanc gaussien centré de variance unité 
% filtré passe-bas de 100000 points
% affichage de la séquence de bruit


clc,home
N=100000;
disp(['Génération d''une réalisation de bruit blanc gaussien'])
disp(['de moyenne nulle et de variance unité de ',num2str(2*N),' échantillons']);
% génération de 200000 échantillons
%
% initialisation du générateur de bruit gaussien
%
disp(' ');
init=input('Donnez un entier pour initialiser le générateur de bruit blanc gaussien : ');
disp(' ');
randn('seed',init);
al=randn(2*N,1);
al=al-mean(al);
al=al/std(al);
% affichage de l'histogramme du bruit blanc N(0,1)
[p,z]=hist(al,30);
scrsz = get(0,'ScreenSize');
fig1=figure('Position',[0.02*scrsz(3) 0.05*scrsz(4) 0.98*scrsz(3) 0.95*scrsz(4)/2]);
bar(z,p),
title(['Histogramme de la réalisation blanche gaussienne de ',num2str(2*N),' échantillons']);
disp(' ')
disp('appuyez sur une touche pour continuer');
disp(' ')
pause
close(fig1);
% filtrage
disp(['filtrage du bruit blanc et affichage de la séquence de ',num2str(N),' échantillons'])
load LPbutt
fal=filter(b,a,al);
% extraction des nbpt points
brf=fal(fix(N/2):fix(N/2)+N-1);
% affichage
scrsz = get(0,'ScreenSize');
fig1=figure('Position',[0.02*scrsz(3) 0.05*scrsz(4) 0.98*scrsz(3) 0.95*scrsz(4)/2]);
%fig1=figure('Units','normal','Position',[0.01 0.44 0.98 0.43]);
plot(0:N-1,brf);axis([0 length(brf)-1 min(brf) max(brf)]);
title('le bruit filtré passe-bas à analyser');
xlabel('indices')
disp(' ')
disp('appuyez sur une touche pour terminer');
pause;
close(fig1)
clear al fal

        
    
        
        

