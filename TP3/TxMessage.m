function [X,Xp,S,Sp,B,Bp] = TxMessage(Msg,SNRX,Sp)

Nchar = length(Msg) ;
msgint = uint8(Msg) ;  
msgbin = dec2bin(msgint)' ;
word = str2num(msgbin(:))' ; 
Nbit = length(word) ;

ftsize = 18 ;

SelectParams = input('Do you want to set the OOK modulation parameters ? (Y/N) : ','s') ;
if upper(SelectParams) == 'Y'
    A = input('Amplitude [1] = ') ;
    if isempty(A), A = 1 ; end
    Fs = input('Sampling Freq. [400] = ') ;
    if isempty(Fs), Fs = 400 ; end
    Fc = input('Carrier Freq. [50] = ') ;
    if isempty(Fc), Fc = 50 ; end
    FM = 0 ; 
    NoiseBand = input('Noise bandwidth [190] = ') ;
    if isempty(NoiseBand), NoiseBand = 190 ; end
    PeriodPerBit = input('Number of period per bit [200] = ') ;
    if isempty(PeriodPerBit), PeriodPerBit = 200 ; end
    T = Nbit*(PeriodPerBit/Fc) ; 
    N = T*Fs ; 
    Phi = input('Initial phase of the carrier [random] = ') ;
    if isempty(Phi), Phi = rand*2*pi ; end 
    disp('User defined parameters...')
else   
    A = 1 ;
    Fs = 400 ;
    Fc = 50 ;
    FM = 0 ; 
    NoiseBand = 190 ;
    PeriodPerBit = 200 ;
    T = Nbit*(PeriodPerBit/Fc) ; 
    N = T*Fs ; 
    Phi = rand*2*pi ;
    disp('Default parameters used...')
end
Sp = struct('A',A,'Fs',Fs,'Fc',Fc,'FM',FM,'T',T,'W',word,'Phi',Phi, ...
    'class','OOK Message') 

      
figure(1), clf,
[S,Sp,M] = OOK(Sp) ;

% SNRX = -10 ; % en dB
PS = Sp.A^2/2 ;
PB = PS/10^(SNRX/10) ;
sigma = sqrt(PB) ;
Bp = struct('sigma',sigma,'Fs',Fs,'B',NoiseBand,'T',T) ;
figure(1), clf,
[B,Bp] = CGN(Bp) ;

[X] = AddSig(S,B) ;

Xp = struct('Msg',Msg, ...
    'A',A, ...
    'Fs',Fs, ...
    'Fc', Fc, ...
    'FM', FM, ...
    'Phi', Phi, ...
    'PeriodPerBit', PeriodPerBit, ...
    'T', T, ...
    'N', N, ...
    'W', word, ...
    'Nchar', Nchar, ...
    'Nbit', Nbit, ...
    'SNRX', SNRX, ...
    'NoiseBand', NoiseBand, ...
    'sigma', sigma) ;

figure(1), clf
subplot(211)
plot(X.time,X.data,'r',S.time,S.data,':b')
% axis([-Inf Inf -1.1 1.1])
axis([-Inf Inf -Inf Inf])
title('Original OOK message','fontsize',ftsize)
xlabel('time (s)') 
subplot(212)

Hs = spectrum.welch ;
set(Hs,'SegmentLength',round(sqrt(N))) ;
SpecS = psd(Hs,S.data,'Fs',Fs) ; 
SpecX = psd(Hs,X.data,'Fs',Fs) ;
hh = plot(SpecS); set(hh,'color','b'), hold on 
hh = plot(SpecX); set(hh,'color','r','linewidth',2), hold off 
xlabel('Frequency (Hz)')
title('Power Spectal Density Estimates (Welch)','fontsize',ftsize)