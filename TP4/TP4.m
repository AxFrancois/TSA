close all;
clc;
clear variables;

%% 1 Signal et contexte
[s,Fs]= audioread('ProtestMonoBruit.wav');
t= 0:1/Fs:(length(s)-1)*1/Fs;

figure()
plot(t,s)

    
%% 2 Estimation de la fonction d’autocorrélation

%resitriction [60,70]
indexmin = find(t<=60);
indexmax = find(t>=70);
s1 = s;%(indexmin(end):indexmax(1));
t1 = t;%(indexmin(end):indexmax(1));

figure()
plot(t1,s1)

%calcul autocorr
K = 200;
[R,lags] = xcorr(s1,K,'biased');
figure()
stem(lags/Fs,R)



%% 3 Identification du modèle AR(M)

M = 20;
MGamma = toeplitz(R(K+1 : K + M+1));
Sol = zeros(M+1,1);
Sol(1,1) = 1;
Phi = pinv(MGamma) * Sol;
H = -Phi(2:M+1) / Phi(1);
figure()
plot(1:1:M , H')


%% 4 Prédiction linéaire
Schapeau = conv(s1, H, 'valid');
figure()
subplot(2,1,1)
hold on
plot(t1,s1)
plot(t1(M+1:end),Schapeau(1:end-1))
subplot(2,1,2)
epsilon = s1(M:end)-Schapeau;
plot(t1(M:end),abs(epsilon))

%% 5 Restauration par seuillage

SSeuillage = s1;
for k = 1:length(SSeuillage)-M
    if abs(epsilon(k))> 0.02
        SSeuillage(k+M-2) = median(s1(k+M-2-10:k+M-2+10));
    end
end

figure()
hold on
plot(t1,s1)
plot(t1,SSeuillage)
sound(SSeuillage,Fs)

%% 6 Restauration par prédiction causale / anticausale
% causal : on l'a déjà fait
%anticausal : 

%{
SchapeauAuticausal = flip(conv(flip(s1), H, 'valid'));
figure()
subplot(2,1,1)
hold on
plot(t1,s1)
plot(t1(2:end-M+2),SchapeauAuticausal)
plot(t1(M+1:end),Schapeau(1:end-1))
legend("s","anti","causal")
subplot(2,1,2)
epsilonAnticausal = s1(1:end-M+1)-SchapeauAuticausal;
plot(t1(1:end-M+1),abs(epsilonAnticausal))


figure()
hold on
plot(t1(M-1:end-1),abs(epsilon))
plot(t1(2:end-M+2),abs(epsilonAnticausal))
%find(abs(epsilon)>0.02)
%find(abs(epsilonAnticausal)> 0.02)

SSeuillage = s1;
Seuil = 0.02;
for k = M-1:length(SSeuillage)-2*M+2
    if abs(epsilon(k))> Seuil && abs(epsilonAnticausal(k+M-3))> Seuil
        SSeuillage(k+M-2) = (Schapeau(k)+ SchapeauAuticausal(k+M-3))/2;
    end
end

figure()
hold on
plot(t1,s1)
plot(t1,SSeuillage)
%sound(FTAtraiter,Fs)
%}

%% 2.6
%causal
s_causal = zeros(length(s1),1); %on cree un vecteur de la taille du signal
s_causal(1:(M-1)) = s1(1:(M-1));% initialisation des M premieres valeurs de l'estimation, egales a celles du signal d'origine
for i = (M+1):1:length(s1) % on parcourt le signal à partir de la Mième valeur
H_k = sum(H(1:length(H)).*s1((i-M):(i-1))); %on cree le filtre h(k) et on calcule sa valeur à partir des M valeurs precedentes du signal
s_causal(i) = H_k; %le signal estime prend la valeur du filtre h(k) determinee en fonction des M echantillons precedents
end
erreur1 = abs(s_causal-s1); %on calcule l'erreur d'estimation

%anticausal
s_anticausal = zeros(length(s1),1); %on cree un vecteur de la taille du signal
s_anticausal(length(s1)-(M-1):length(s1)) = s1(length(s1)-(M-1):length(s1));% initialisation des M dernieres valeurs de l'estimation, egales a celles du signal d'origine
for i = length(s1)-(M+1):-1:1 % on parcourt le signal dans le sens inverse à partir de la Mième valeur en partant de la fin
H_k = sum(H(1:length(H)).*s1((i+1):(i+M))); %on cree le filtre h(k) et on calcule sa valeur à partir des M valeurs suivantes du signal
s_anticausal(i) = H_k; %le signal estime prend la valeur du filtre h(k) determinee en fonction des M echantillons suivants
end
erreur2 = abs(s_anticausal-s1); %on calcule l'erreur d'estimation
seuil2=0.1;
s_final = zeros(1,length(t1)); %on cree le vecteur du nouveau signal, de la meme taille que le signal original
for k = 1:length(t1(M:end)) %on parcout le signal
if (erreur1(k)>seuil2) && (erreur2(k)>seuil2) %si les 2 erreurs d'estimation sont superieures au seuil
s_final(k) = (s_causal(k)+s_anticausal(k))/2; %le nouveau signal prend la valeur de la moyenne entre les 2 signaux calcules precedemment
else
s_final(k) = s1(k); %le signal garde la meme valeur
end
end
%sound(s_final,Fs);
figure(7);
plot(t1,s1,'b',t1,s_final,'r')
title('Signal final')
xlabel('temps (s)')
ylabel('Amplitude')
legend('s(t)','s_f_i_n_a_l(t)')
axis tight