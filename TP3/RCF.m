function [Y,RCFp] = RCF (X,RCFp)

% [Y,RCFp] = RCF (X,RCFp) filters the signal structure X with a digital lowpass RC filter whose 
% parameters are specified in the RCFp structure.
% The z-transform of a lowpass RC filter is equal to
% H(z) = B(z)/A(z) = (1-a) / (1 - a z^(-1)) 
% where a = exp(-T/RC), and T is the sampling period
% RCF diplays in a single window plot, respectively the time and the frequency responses
% of the filter, the input signal and the output signal.
%
% Inputs
%
% - X     input signal structure with the following fields:
%           - data : 1-byN vector containing the data samples
%           - time : 1-byN vector containing the time samples
%           - Fs   : scalar indicating the sampling frequency
% - RCFp  parameter structure with following fields:
%           - Fs   : scalar indicating the sampling frequency (must be
%           identical to that of X)
%           - RC   : scalar defining the time constant RC (must be larger
%           than 1/Fs)
%
% Outputs
%
% - Y     output signal structure with the following fields:
%           - data : 1-byN vector containing the data samples
%           - time : 1-byN vector containing the time samples
%           - Fs   : scalar indicating the sampling frequency
% - RCFp   parameter structure (same as input)

% PG : october 2014

ftsize = 14 ;

if nargin == 2
    if ~isstruct(X)
        error('Input ''X'' must be a valid signal structure')
    end
    if ~isstruct(RCFp)
        error('Input variable ''RCFp'' of RCF.m must be a valid structure')
    end
elseif nargin == 1
    RCFp = struct ;
    RCFp.Fs = input('Sampling frequency (Hz) = ') ;
    while RCFp.Fs ~= X.Fs
        warning(['Mismatch with sampling frequency of signal X [',num2str(X.Fs),'Hz]'])
        RCFp.Fs = input('Sampling frequency (Hz) = ') ;
    end
    RCFp.RC = input(['RC constant time (>',num2str(1/RCFp.Fs),'s) = ']) ;
    RCFp.class = 'RC lowpass filter parameters' ;
end

if RCFp.Fs ~= X.Fs
    error('Sampling frequencies mismatch')
end

Ts = 1/RCFp.Fs ;
a = exp(-Ts/RCFp.RC ) ;
B = 1-a ;
A = [1 -a] ;

clf,
subplot(321)
[h,t] = impz(B,A,5*RCFp.RC/Ts,RCFp.Fs) ;
plot(t,h,'linewidth',2)
% AddTick('XTick',RCFp.RC,'RC')
grid
title(['Imp. Resp. (RC=',num2str(RCFp.RC),'s)'],'fontsize',ftsize) 
xlabel('time (s)','fontsize',ftsize)
text(0.25,0.65,'h(t=nTs)=(1-e^{-Ts/RC})e^{-t/RC}','Units','normalized','fontsize',ftsize)

[H,F] = freqz(B,A,length(X.time),RCFp.Fs) ;
Fc = 1/(2*pi*RCFp.RC) ;
subplot(322)
semilogx(F,20*log10(abs(H)),'linewidth',2) ; 
hold on
semilogx([min(get(gca,'xtick')) Fc],[-3 -3],'--r')
semilogx([Fc Fc],[min(get(gca,'ytick')) -3],'--r')
hold off
% AddTick('XTick',Fc,'Fc')
% AddTick('YTick',-3,'-3dB')
grid,
xlabel('Frequency (Hz)','fontsize',ftsize) 
title(['Freq. resp. (Fc=',num2str(Fc),'Hz)'],'fontsize',ftsize) 


y = filter(B,A,X.data) ;
subplot(312)
plot(X.time,X.data,':k'), 
xlabel('time (s)','fontsize',ftsize) 
title('Input signal','fontsize',ftsize)

subplot(313)
plot(X.time,y,'r','linewidth',2),
grid
xlabel('time (s)','fontsize',ftsize) 
title('Lowpass RC filtered signal','fontsize',ftsize)

Y.data = y ;
Y.time = X.time ;
Y.Fs = RCFp.Fs ;

