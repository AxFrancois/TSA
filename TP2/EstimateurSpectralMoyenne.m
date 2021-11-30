function [Gamma2, VecteurFreq] = EstimateurSpectralMoyenne(x, N, M, NFFT)

seq = x(1:N);
[Gamma2,VecteurFreq] = pwelch(seq,rectwin(M),0,NFFT,1,'twosided');

end

