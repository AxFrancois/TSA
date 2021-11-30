function [Gth,Gbiais,fth]=sptheo(Q,method,fenetre);
% [Gth,Gbiais,f]=sptheo(Q,method,fenetre);
% calcule dans le cadre du TP Estimation spectrale
%  - Gth : la valeur en dB de la DSPM du bruit blanc filtré entre 0 et 0,5
%  - Gbiais : la valeur en dB de Gth convolué par la grandeur régissant le
%  biais attaché à la 'method'
%  - fth : un vecteur fréquence réduite de même taille que Gth et Gbiais 
% method peut prendre 3 valeurs :
%   'simple'
%   'moyenne'
%   'welch'
%
% Si method='simple', Q représente la longueur de l'échantillon analysé
%
% Si method='moyenne' ou 'welch', Q représente la longueur d'une tranche
%
% Si method='simple' ou 'moyenne' le paramètre fenetre est ignoré
%
% Si method='welch', il faut spécifier le nom de la fenêtre dans le 3ème
% paramètre
%
% Exemple : [Gth,Gbiais,f]=sptheo(1024,'welch','hamming');

% fonction développée par N. Gache le 25/3/2010

%coefficients du filtre
load LPbutt
if or(strcmp(method,'simple'),strcmp(method,'moyenne'))
    % dans le cas 'simple' et 'moyenné', tranches de longueur Q,  
    % la fenêtre de Bartlett en jeu va de -(Q-1) à Q-1
    LBart=2*Q-1;
    fenetre='bartlett';
    % recherche de la puissance de 2 supérieure à la taille de la fenêtre
    % pour définir le nbre de point sur lequel on calcule les TF
    np2=nextpow2(LBart);
    ntfr=pow2(np2);
    % spectre théorique complet entre 0 et 0.5
    [H,fth]=freqz(b,a,ntfr/2,1);
    H2=abs(H).^2;
    Gth=10*log10(H2);
    % calcul de la version biaisée
    % Gth convolué par la TF de la fenêtre
    % on calcule le produit en temps puis on revient en fréquence
    %
    % élaboration du vecteur de la DSPM entre 0 et 1
    spth=[H2;0;flipud(H2(2:ntfr/2))]; 
    % calcul de son antécédent en temps
    tspth=real(ifft(spth)); 
    % calcul de la fenêtre paire de Bartlett
    eval(['wQ=',fenetre,'(LBart);']);
    % positionnement correct entre t=0 et  
    wBQ=[wQ(Q:2*Q-1);zeros(ntfr-LBart,1);wQ(1:Q-1)];
    % multiplication des deux séquences en temps
    z=tspth.*wBQ;
    % retour en fréquence entre 0 et 1
    Gbiais=real(fft(z));
    % limitation entre 0 et 0,5 et mise en dB
    Gbiais=10*log10(Gbiais(1:length(Gbiais)/2));
end
if strcmp(method,'welch')
    Lf=Q;
    % recherche de la puissance de 2 supérieure à la taille de la fenêtre
    % pour définir le nbre de point sur lequel on calcule les TF
    np2=nextpow2(Lf);
    nfft=pow2(np2);
    [h,fth]=freqz(b,a,nfft,1);
    mag2=abs(h).^2;
    Gth=10*log10(mag2);
    % calcul du spectre théorique biaisé
    % spectre théorique complet
    spth=[mag2;0;flipud(mag2(2:nfft))]; 
    tspth=real(ifft(spth)); % son antécédent en temps
    %calcul de la fenêtre
    eval(['wf=',fenetre,'(Lf);']);
    % calcul de la TF de la fenêtre
    Hf=fft(wf,2*nfft);
    P=(abs(Hf).^2)/sum(wf.*wf);
    p=ifft(P);
    % multiplication des deux séquences en temps
    z=tspth.*real(p);
    % retour en fréquence
    spconv=real(fft(z));
    Gbiais=10*log10(spconv(1:length(spconv)/2));
end
    
    