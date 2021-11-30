close all;
clc;
clear variables;

x = genbrfil();

%% figure 1
nb1 = 1;
nb2 = 256;
NTF = 4096;

[Gamma1,VecteurFreq, N] = EstimateurSpectralSimple(x,nb1,nb2, NTF);
[Gth,Gbiais,f]=sptheo(N,'simple');

figure(1)
hold on
plot(VecteurFreq,10*log10(Gamma1))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])

%% figure 2
nb1 = 1;
nb2 = 4096;
NTF = 4096;

[Gamma1,VecteurFreq, N] = EstimateurSpectralSimple(x,nb1,nb2, NTF);
[Gth,Gbiais,f]=sptheo(N,'simple');

figure(2)
hold on
plot(VecteurFreq,10*log10(Gamma1))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])

%% figure 3
nb1 = 1;
nb2 = 1024;
NTF = 4096;

[Gamma1,VecteurFreq, N] = EstimateurSpectralSimple(x,nb1,nb2, NTF);
[Gth,Gbiais,f]=sptheo(N,'simple');

figure(3)
hold on
plot(VecteurFreq,10*log10(Gamma1))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])

%% figure 4
nb1 = 50000;
nb2 = 51024;
NTF = 4096;

[Gamma1,VecteurFreq, N] = EstimateurSpectralSimple(x,nb1,nb2, NTF);
[Gth,Gbiais,f]=sptheo(N,'simple');

figure(4)
hold on
plot(VecteurFreq,10*log10(Gamma1))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])

%% figure 5
nb1 = 1;
nb2 = 4096;
NTF = 4096;

[Gamma1,VecteurFreq, N] = EstimateurSpectralSimple(x,nb1,nb2, NTF);
[Gth,Gbiais,f]=sptheo(N,'simple');

figure(5)
hold on
plot(VecteurFreq,10*log10(Gamma1))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])

%% figure 6
nb1 = 1;
nb2 = 4096;
NTF = 2^16;

[Gamma1,VecteurFreq, N] = EstimateurSpectralSimple(x,nb1,nb2, NTF);
[Gth,Gbiais,f]=sptheo(N,'simple');

figure(6)
hold on
plot(VecteurFreq,10*log10(Gamma1))
plot(f,Gth)
plot(f,Gbiais)
axis([0 0.5 -50 +10])
