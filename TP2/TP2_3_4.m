close all;
clc;
clear variables;

%fenetre

%{%}
%% figure 10
x = genbrfil();

N = 4096;
Nom_fenetre = 'blackman';
M = 1500;
NOVERLAP = 0 * M;
NFFT = 4096;
[Gamma3,VecteurFreq] = EstimateurSpectralWelch(x,N,Nom_fenetre,M,NOVERLAP,NFFT);
[Gth,Gbiais,f]=sptheo(NFFT,'welch',Nom_fenetre);

figure(10)
hold on
plot(VecteurFreq,10*log10(Gamma3))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])

%% figure 11
N = 4096;
Nom_fenetre = 'blackman';
M = 1500;
NOVERLAP = 0.5 * M;
NFFT = 4096;
[Gamma3,VecteurFreq] = EstimateurSpectralWelch(x,N,Nom_fenetre,M,NOVERLAP,NFFT);
[Gth,Gbiais,f]=sptheo(NFFT,'welch',Nom_fenetre);

figure(11)
hold on
plot(VecteurFreq,10*log10(Gamma3))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])

%% figure 12
N = 4096;
Nom_fenetre = 'rectwin';
M = 1500;
NOVERLAP = 0.5 * M;
NFFT = 4096;
[Gamma3,VecteurFreq] = EstimateurSpectralWelch(x,N,Nom_fenetre,M,NOVERLAP,NFFT);
[Gth,Gbiais,f]=sptheo(NFFT,'welch',Nom_fenetre);

figure(12)
hold on
plot(VecteurFreq,10*log10(Gamma3))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])

%% figure 13
N = 4096;
Nom_fenetre = 'hamming';
M = 1500;
NOVERLAP = 0.5 * M;
NFFT = 4096;
[Gamma3,VecteurFreq] = EstimateurSpectralWelch(x,N,Nom_fenetre,M,NOVERLAP,NFFT);
[Gth,Gbiais,f]=sptheo(NFFT,'welch',Nom_fenetre);

figure(13)
hold on
plot(VecteurFreq,10*log10(Gamma3))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])

%% figure 14
N = 2^16;
Nom_fenetre = 'blackman';
M = 1000;
NOVERLAP = 0.5 * M;
NFFT = N;
[Gamma3,VecteurFreq] = EstimateurSpectralWelch(x,N,Nom_fenetre,M,NOVERLAP,NFFT);
[Gth,Gbiais,f]=sptheo(NFFT,'welch',Nom_fenetre);

figure(14)
hold on
plot(VecteurFreq,10*log10(Gamma3))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])