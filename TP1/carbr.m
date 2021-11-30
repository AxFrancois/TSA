function carbr(moy,ecartype,N)
% function carbr(moy,ecartype,N)
% estime la densit? de probabilit? de la somme 
%	d'un signal carr? de fr?quence 110 Hz 
%	et d'un bruit blanc gaussien
% le tout ?chantillonn? ? 100 KHz
%
% variables d'entr?e 
%	moy moyenne du bruit
%	ecartype ?cart-type du bruit
%	N nombre de points de signal ? analyser
%
% on affiche le m?lange signal +bruit
%	     la ddp estim?e

x=square(2*pi*0.0011*(0:N-1));
br=randn(1,N);
sig=((br*ecartype)+moy)+x;
[Nbre,y]=hist(sig,30);
pas=y(2)-y(1);
ddpest=Nbre/N/pas;
t=(0:N-1)/1e5;
[ormin,ormax]=tracord(sig);

figure(1)
hold on
subplot(2,1,1),
plot(t*1000,sig)
title(['signal carre + bruit - moyenne ',num2str(moy),' ecart-type ',num2str(ecartype)])
xlabel('millisecondes')
set(gca,'Xlim',[0 t(N)*1000],'YLim',[ormin ormax])
subplot(2,1,2),plot(y,ddpest);
title(['ddp estimee avec ',sprintf('%6.0f',N),' points']);
title(['ddp estimee avec ',num2str(N),' points']);
xlabel('amplitude')
set(gca,'Xlim',[y(1)-pas y(30)+pas],'YLim',[0 1.1*max(ddpest)])

%imprime;


