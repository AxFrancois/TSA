close all;
clc;
clear variables;

%% 1.1 Synthèse du bruit
Fs = 500;
BPBruit = 160;
nu0 = 100;
OrdrePB = 6;
figure(1)
Bp = struct('sigma',sqrt(5),'Fs',Fs,'B',BPBruit,'T',100) ;
[B,Bp] = CGN(Bp) ;
disp(['Moyenne B : ', num2str(mean(B.data))])
disp(['Variance B : ', num2str(std(B.data))])

%% 1.2 Filtre passe-bande

Deltanu = 16;
F0 = nu0;
figure(2)
Fp = struct('Fs',Fs,'F0',F0,'Dnu',Deltanu,'order',OrdrePB,'class','BP filter');
[Yb,Fp] = BPF(B,Fp);

disp(['Moyenne Y : ', num2str(mean(Yb.data))])
disp(['Variance Y : ', num2str(std(Yb.data))])
%sqrt(1/Y.time(end)* trapz(Y.time,abs(Y.data).^2))

%% 1.3 Carré et RC passe-bas
Deltanu = 16;

DeltanuRC = [2 , 20 , 100];

for k = 1:3
    disp('-----')
    figure()
    Zb = SquareSig(Yb);
    disp(['Kurtosis Zb : ', num2str(kurtosis(Zb.data))])
    RC = DeltanuRC(k)/Deltanu;
    RCFp = struct('Fs',Fs,'RC',RC);
    [Wb,RCFp] = RCF(Zb,RCFp);
    disp(['Moyenne Wb : ', num2str(mean(Wb.data))])
    disp(['Variance Wb : ', num2str(std(Wb.data))])
    disp(['Kurtosis Wb : ', num2str(kurtosis(Wb.data))])
    disp('-----Corrigé-----')
    index = find(Wb.time >= 5*RC);
    WbRogne = Wb.data(index(1):end);
    %disp(Wb.time(index(1)))
    disp(['Moyenne Wb : ', num2str(mean(WbRogne))])
    disp(['Variance Wb : ', num2str(std(WbRogne))])
    disp(['Kurtosis Wb : ', num2str(kurtosis(WbRogne))])
end



