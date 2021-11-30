close all;
clc;
clear variables;


%%  2.2.1

%[x1, x2, x3, a, b] = SignAleatoires(N,B,m3,sigma3)
%[fx,xout] = CalculHistogram(x, M)

Fs = 1000;
N = 1000;
t = 0:1/Fs:(N-1)*1/Fs;
B = 100;
m3 = 1;
sigma3 = 2;

%{
[x1, x2, x3, a, b] = SignAleatoires(N,B/Fs,m3,sigma3);

figure(1)
subplot(2,4,1)
plot(t,x1)
title('x1','FontSize', 12, 'FontName','times')
subplot(2,4,2)
plot(t,x2)
title('x2','FontSize', 12, 'FontName','times')
subplot(2,4,3)
plot(t,x3)
title('x3','FontSize', 12, 'FontName','times')
subplot(2,4,4)
[H,w] = freqz(b,a,1024,Fs);
plot(w,20*log10(abs(H)))
title('module du gain complexe en dB','FontSize', 12, 'FontName','times')

subplot(2,4,5)
hold on
[fx1,xout1] = CalculHistogram(x1);
t1 = xout1(1):0.01:xout1(end);
plot(t1, 1/(sqrt(2*pi)) * exp(-1/2 * (t1).^2))
legend("Histogramme", "Empirique", "Theorique")

subplot(2,4,6)
hold on
[fx2,xout2] = CalculHistogram(x2);
Gamma0 = 1/Fs;
sigmax2th = sqrt(Gamma0*2*B);
t2 = xout2(1):0.01:xout2(end);
plot(t2, 1/(sigmax2th*sqrt(2*pi)) * exp(-1/2 * (t2/sigmax2th).^2))
legend("Histogramme", "Empirique", "Theorique")

subplot(2,4,7)
hold on
[fx3,xout3] = CalculHistogram(x3);
sigmax3th = sigmax2th*sigma3;
t3 = xout3(1):0.01:xout3(end);
plot(t3, 1/(sigmax3th*sqrt(2*pi)) * exp(-1/2 * ((t3 - m3)/sigmax3th).^2))
legend("Histogramme", "Empirique", "Theorique")


%%  2.2.2

Fs = 1000;
B = 100;
m3 = 1;
sigma3 = 2;
M = 20;

figure(2)
for k = 1:8
    Pow = 3+k;
    N = 2^Pow;
    %disp(num2str(Pow))
    [x1, x2, x3, a, b] = SignAleatoires(N,B/Fs,m3,sigma3);
    subplot(2,4,k)
    [fx1,xout1] = CalculHistogram(x1, M);   
    t1 = xout1(1):0.01:xout1(end);
    plot(t1, 1/(sqrt(2*pi)) * exp(-1/2 * (t1).^2))
    plot(xout1, 1/(sqrt(2*pi)) * exp(-1/2 * (xout1).^2) + sqrt(fx1/N .* (1/(xout1(2)-xout1(1)) - fx1)))
    plot(xout1, 1/(sqrt(2*pi)) * exp(-1/2 * (xout1).^2) - sqrt(fx1/N .* (1/(xout1(2)-xout1(1)) - fx1)))
    title(['2^{', num2str(Pow),'}'] ,'FontSize', 12, 'FontName','times')
    legend("Histogramme", "Empirique", "Theorique", "Intervalle haut", "Intervalle bas")
end


%% 2.2.3

N = 1000;

figure(3)
subplot(1,3,1)
M=1;    %tous les échantillons sont dans le même intervalle : variance nulle, incertitude de confiance maximale
[x1, x2, x3, a, b] = SignAleatoires(N,B/Fs,m3,sigma3);
[fx1,xout1] = CalculHistogram(x1, M);
t1 = xout1(1):0.01:xout1(end);
stem(t1, 1/(sqrt(2*pi)) * exp(-1/2 * (t1).^2))
%Biai estimation
sqrt(fx1/N .* (1/(xout1(1)) - fx1))


subplot(1,3,2)
M=1000; %~1 echantillon par intervalle : variance maximale, incertitude de confiance nulle
[x1, x2, x3, a, b] = SignAleatoires(N,B/Fs,m3,sigma3);
[fx1,xout1] = CalculHistogram(x1, M);
t1 = xout1(1):0.01:xout1(end);
plot(t1, 1/(sqrt(2*pi)) * exp(-1/2 * (t1).^2))
%Biai estimation
max(sqrt(fx1/N .* (1/(xout1(2)-xout1(1)) - fx1)))

subplot(1,3,3)
[x1, x2, x3, a, b] = SignAleatoires(N,B/Fs,m3,sigma3);
[fx1,xout1] = CalculHistogram(x1); %interval optimal
t1 = xout1(1):0.01:xout1(end);
plot(t1, 1/(sqrt(2*pi)) * exp(-1/2 * (t1).^2))
%Biai estimation
max(sqrt(fx1/N .* (1/(xout1(2)-xout1(1)) - fx1)))
%}
%% 2.2.4

Fs = 1000;
N = 10000;
t = 0:1/Fs:(N-1)*1/Fs;
B = 5;
m3 = 1;
sigma3 = 2;

[x1, x2, x3, a, b] = SignAleatoires(N,B/Fs,m3,sigma3);

figure(4) 
subplot(1,4,1)
[H,w] = freqz(b,a,1024,Fs);
plot(w,20*log10(abs(H)))
title('module du gain complexe en dB','FontSize', 12, 'FontName','times')

subplot(1,4,2)
plot(t,x2)
title('x2','FontSize', 12, 'FontName','times')

subplot(1,4,3)
hold on
[fx2,xout2] = CalculHistogram(x2);
Gamma0 = 1/Fs;
sigmax2th = sqrt(Gamma0*2*B);
t2 = xout2(1):0.01:xout2(end);
plot(t2, 1/(sigmax2th*sqrt(2*pi)) * exp(-1/2 * (t2/sigmax2th).^2))
legend("Histogramme", "Empirique", "Theorique")
%{
%Plus gaussienne : trop de point filtré, courbe éloignée de la courbe
%théorique
%solution : augmenter le nombre de point, N = 10000 c'est good
%}
