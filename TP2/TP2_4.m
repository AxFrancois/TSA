close all;
clc;
clear variables;

load sig


%% figure 15
N = 100000;
NFFT = 2^17;
figure(15)
[Gamma1,VecteurFreq1, N] = EstimateurSpectralSimple(s,1,N, NFFT);
semilogy(VecteurFreq1,Gamma1)
axis([0 0.5 10 10^7])
figure(16)

%% figure 16
N = 100000;
M = 5000;
NFFT = 2^17;
[Gamma2, VecteurFreq2] = EstimateurSpectralMoyenne(s, N, M, NFFT);
semilogy(VecteurFreq2,Gamma2)
axis([0 0.5 10 10^7])

%% figure 17
N = 100000;
Nom_fenetre = 'blackman';
M = 5000;
NOVERLAP = 0.5 * M;
NFFT = 2^17;
[Gamma3,VecteurFreq3] = EstimateurSpectralWelch(s,N,Nom_fenetre,M,NOVERLAP,NFFT);
figure(17)
semilogy(VecteurFreq3,Gamma3)
axis([0 0.5 10 10^7])