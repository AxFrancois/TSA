close all;
clc;
clear variables;

x = genbrfil();

%% figure 7
N = 4096;
M = 40;
NFFT = 4096; %prendre proche de M : ex M = 500 donc NFFT = 2^9

[Gamma2, VecteurFreq] = EstimateurSpectralMoyenne(x, N, M, NFFT);
[Gth,Gbiais,f]=sptheo(M,'moyenne');

figure(7)
hold on
plot(VecteurFreq,10*log10(Gamma2))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])

%% figure 8
N = 4096;
M = 1024;
NFFT = 4096; %prendre proche de M : ex M = 500 donc NFFT = 2^9

[Gamma2, VecteurFreq] = EstimateurSpectralMoyenne(x, N, M, NFFT);
[Gth,Gbiais,f]=sptheo(M,'moyenne');

figure(8)
hold on
plot(VecteurFreq,10*log10(Gamma2))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])

%% figure 9
N = 4096;
M = 350;
NFFT = 4096; %prendre proche de M : ex M = 500 donc NFFT = 2^9

[Gamma2, VecteurFreq] = EstimateurSpectralMoyenne(x, N, M, NFFT);
[Gth,Gbiais,f]=sptheo(M,'moyenne');

figure(9)
hold on
plot(VecteurFreq,10*log10(Gamma2))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])