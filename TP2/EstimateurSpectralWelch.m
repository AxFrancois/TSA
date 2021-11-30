function [Gamma3,VecteurFreq] = EstimateurSpectralWelch(x,N,Nom_fenetre,M,NOVERLAP,NFFT)

seq = x(1:N);

eval(['WIN=',Nom_fenetre,'(M);']);

[Gamma3,VecteurFreq] = pwelch(seq,WIN,NOVERLAP,NFFT,1,'twosided');

end

