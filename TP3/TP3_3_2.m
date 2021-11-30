close all;
clc;
clear variables;

%% 3.1.1
% Synthèse du bruit
Fs = 500;
BPBruit = 160;
nu0 = 100;
duration = 100;
OrdrePB = 6;
figure(1)
Bp = struct('sigma',sqrt(5),'Fs',Fs,'B',BPBruit,'T',duration) ;
[B,Bp] = CGN(Bp) ;

% Synthèse du signal
figure(2)
Sp = struct('Fs',Fs,'A',1,'Fc',100,'FM',0.05,'Phi',2*pi*rand(1),'T',duration,'W',[]);
[S,Sp,M] = OOK(Sp);

%Synthèse X(t)
[X] = AddSig(S,B);

%Filtre passe-bande
Deltanu = 16;
F0 = nu0;
figure(3)
Fp = struct('Fs',Fs,'F0',F0,'Dnu',Deltanu,'order',OrdrePB,'class','BP filter');
[Y,Fp] = BPF(X,Fp);

%disp(['Moyenne Y : ', num2str(mean(Yb.data))])
%disp(['Variance Y : ', num2str(std(Yb.data))])


% Carré et RC passe-bas
Deltanu = 16;

DeltanuRC = 20;

figure()
Zb = SquareSig(Y);
RC = DeltanuRC/Deltanu;
RCFp = struct('Fs',Fs,'RC',RC);
[W,RCFp] = RCF(Zb,RCFp);
index = find(W.time >= 5*RC);
WbRogne = W.data(index(1):end);
%disp(Wb.time(index(1)))
disp(['Moyenne W : ', num2str(mean(WbRogne))])
%disp(['Variance W : ', num2str(std(WbRogne))])
%disp(['Kurtosis W : ', num2str(kurtosis(WbRogne))])

%% 3.1.2

figure()
subplot(4,1,1)
plot(S.time,S.data)
subplot(4,1,2)
plot(X.time,X.data)
subplot(4,1,3)
plot(W.time,W.data)
subplot(4,1,4)
Detection = W.data>mean(W.data);
plot(S.time,Detection)
