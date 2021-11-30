close all;
clc;
clear variables;

%% 2.1.1
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
figure()
Sp = struct('Fs',Fs,'A',1,'Fc',100,'T',duration, 'Phi', 2*pi*rand(1), 'W', [], 'FM', 0);
[S,Sp,M] = OOK(Sp);

%Synthèse X(t)
[X] = AddSig(S,B);

%% 2.1.2 Filtre passe-bande

Deltanu = 16;
F0 = nu0;
figure()
Fp = struct('Fs',Fs,'F0',F0,'Dnu',Deltanu,'order',OrdrePB,'class','BP filter');
[Y,Fp] = BPF(X,Fp);

%disp(['Moyenne Y : ', num2str(mean(Yb.data))])
%disp(['Variance Y : ', num2str(std(Yb.data))])


%% 2.2 Carré et RC passe-bas
Deltanu = 16;

DeltanuRC = [2 , 20 , 100];

for k = 1:3
    disp('-----')
    figure()
    Zb = SquareSig(Y);
    RC = DeltanuRC(k)/Deltanu;
    RCFp = struct('Fs',Fs,'RC',RC);
    [W,RCFp] = RCF(Zb,RCFp);
    index = find(W.time >= 5*RC);
    WbRogne = W.data(index(1):end);
    %disp(Wb.time(index(1)))
    disp(['Moyenne W : ', num2str(mean(WbRogne))])
    disp(['Variance W : ', num2str(std(WbRogne))])
    disp(['Kurtosis W : ', num2str(kurtosis(WbRogne))])
end
