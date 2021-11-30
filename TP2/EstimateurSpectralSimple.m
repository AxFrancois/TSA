function [Gamma1,VecteurFreq, N] = EstimateurSpectralSimple(x,nd,nf, nFFT)

SeqAAnalyser = x(nd:nf);
N = nf - nd +1;

TF = fft(SeqAAnalyser,nFFT);
Gamma1 =1/N * abs(TF).^2;
VecteurFreq = 0:1/nFFT:1-1/nFFT;
end

