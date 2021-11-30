function fenetre;
%function fenetre(nfen);
% programme fenetre
%
% etude des fenetres
% 
% ce module permet de 
%	visualiser l'allure de 6 fenêtres de pondération
%	afficher leur spectre en échelle linéaire
%			      en échelle logarithmique
% pour des fenêtres de longueur nfen pts
%
close all
nfen=40;
w1=rectwin(nfen);
w2=bartlett(nfen);
w3=hann(nfen);
w4=hamming(nfen);
w5=blackman(nfen);
w6=gausswin(nfen);  
figure(1)
clf
subplot(3,2,1),plot(-2:nfen+1,[0;0;w1;0;0])
set(gca,'XLim',[-2 nfen+1],'YLim',[0 1.1])
title(['fenetre rectangulaire de ',num2str(nfen),' points'])
subplot(3,2,2),plot(-2:nfen+1,[0;0;w2;0;0])
set(gca,'XLim',[-2 nfen+1],'YLim',[0 1.1])
title(['fenetre triangulaire de ',num2str(nfen),' points'])
subplot(3,2,3),plot(-2:nfen+1,[0;0;w3;0;0])
set(gca,'XLim',[-2 nfen+1],'YLim',[0 1.1])
title(['fenetre de Hanning de ',num2str(nfen),' points'])
subplot(3,2,4),plot(-2:nfen+1,[0;0;w4;0;0])
set(gca,'XLim',[-2 nfen+1],'YLim',[0 1.1])
title(['fenetre de Hamming de ',num2str(nfen),' points'])
subplot(3,2,5),plot(-2:nfen+1,[0;0;w5;0;0])
set(gca,'XLim',[-2 nfen+1],'YLim',[0 1.1])
title(['fenetre de Blackman de ',num2str(nfen),' points'])
subplot(3,2,6),plot(-2:nfen+1,[0;0;w6;0;0])
set(gca,'XLim',[-2 nfen+1],'YLim',[0 1.1])
title(['fenetre de Gauss de ',num2str(nfen),' points'])
nfft=16*2^nextpow2(nfen); 
spfft1=fft(w1',nfft);
spfft2=fft(w2',nfft);
spfft3=fft(w3',nfft);
spfft4=fft(w4',nfft);
spfft5=fft(w5',nfft);
spfft6=fft(w6',nfft);
sp1=abs([spfft1((nfft/2)+1:nfft) spfft1(1:(nfft/2)+1)]);
sp2=abs([spfft2((nfft/2)+1:nfft) spfft2(1:(nfft/2)+1)]);
sp3=abs([spfft3((nfft/2)+1:nfft) spfft3(1:(nfft/2)+1)]);
sp4=abs([spfft4((nfft/2)+1:nfft) spfft4(1:(nfft/2)+1)]);
sp5=abs([spfft5((nfft/2)+1:nfft) spfft5(1:(nfft/2)+1)]);
sp6=abs([spfft6((nfft/2)+1:nfft) spfft6(1:(nfft/2)+1)]);
w=0:1/nfft:(nfft/2)/nfft;
nu=[-fliplr(w(2:(nfft/2)+1)) w];
%nu = nu * (1/(nu(2)-nu(1)));
figure(2),
subplot(3,2,1),plot(nu,sp1)
set(gca,'YLim',[0 1.1*max(sp1)])
set(gca,'XLim',[nu(1) nu(length(nu))])
title('MODULE DES SPECTRES')
text(-0.45,30,'rectangulaire')
subplot(3,2,2),plot(nu,sp2)
set(gca,'YLim',[0 1.1*max(sp2)])
set(gca,'XLim',[nu(1) nu(length(nu))])
title('ECHELLES LINEAIRES')
text(-0.45,15,'triangulaire');
subplot(3,2,3),plot(nu,sp3)
set(gca,'YLim',[0 1.1*max(sp3)])
set(gca,'XLim',[nu(1) nu(length(nu))])
text(-0.45,15,'Hanning');
subplot(3,2,4),plot(nu,sp4)
set(gca,'YLim',[0 1.1*max(sp4)])
set(gca,'XLim',[nu(1) nu(length(nu))])
text(-0.45,15,'Hamming');
subplot(3,2,5),plot(nu,sp5)
set(gca,'YLim',[0 1.1*max(sp5)])
set(gca,'XLim',[nu(1) nu(length(nu))])
text(-0.45,12,'Blackman');
subplot(3,2,6),plot(nu,sp6)
set(gca,'YLim',[0 1.1*max(sp6)])
set(gca,'XLim',[nu(1) nu(length(nu))])
text(-0.45,15,'Gauss');
figure(3)
subplot(3,2,1),plot(nu,20*log10(sp1/max(sp1)))
set(gca,'YLim',[-60 5])
set(gca,'XLim',[nu(1) nu(length(nu))])
title('MODULE DES SPECTRES')
text(-0.45,-5,'rectangulaire')
subplot(3,2,2),plot(nu,20*log10(sp2/max(sp2)))
set(gca,'YLim',[-60 5])
set(gca,'XLim',[nu(1) nu(length(nu))])
title('ECHELLES LOGARITHMIQUES en dB')
text(-0.45,-5,'triangulaire');
subplot(3,2,3),plot(nu,20*log10(sp3/max(sp3)))
set(gca,'YLim',[-60 5])
set(gca,'XLim',[nu(1) nu(length(nu))])
text(-0.45,-5,'Hanning');
subplot(3,2,4),plot(nu,20*log10(sp4/max(sp4)))
set(gca,'YLim',[-60 5])
set(gca,'XLim',[nu(1) nu(length(nu))])
text(-0.45,-5,'Hamming');
subplot(3,2,5),plot(nu,20*log10(sp5/max(sp5)))
set(gca,'YLim',[-60 5])
set(gca,'XLim',[nu(1) nu(length(nu))])
text(-0.45,-5,'Blackman');
subplot(3,2,6),plot(nu,20*log10(sp6/max(sp6)))
set(gca,'YLim',[-60 5])
set(gca,'XLim',[nu(1) nu(length(nu))])
text(-0.45,-5,'Gauss');


		    		
