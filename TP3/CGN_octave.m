function [X,Xp] = CGN(Xp) 

% [X,Xp] = CGN(Xp)  generates a filtered, centered, gaussian noise X
% according to the parameters specified in the parameter structure Xp
% CGN displays in the current window plot, the synthesised trace and the
% corresponding estimated power spectrum density. 
%
% Input
%
% Xp        parameter structure containg the follwoing fileds:
%           - sigma : standard deviation
%           - Fs    : scalar indicating the sampling frequency
%           - B     : the bandwidth (in Hz, B < Fs/2)
%           - T     : duration of the generated trace (in seconds)
%        If varargin is left empty, each field of 'Xp' is defined online
%
% Outputs
%
% - X     signal structure with the following fields:
%           - data : 1-byN vector containing the data samples
%           - time : 1-byN vector containing the time samples
%           - Fs   : scalar indicating the sampling frequency
% - Xp    parameter structure (same as input)
%
% Example
%
% Xp = struct('sigma',1,'Fs',1000,'B',200,'T',10) ;
% [X,Xp] = CGN(Xp) ;
% % or 
% [X,Xp] = CGN() ;

% PG : october 2014

if nargin == 1
    if ~isstruct(Xp)
        error('Input variable of CGN.m must be a valid structure')
    end
else
    Xp = struct ;
    Xp.sigma = input('Standard deviation (V) = ') ; % ecart-type
    Xp.Fs = input('Sampling frequency (Hz) = ') ; % frequence d'echantillonnage
    Xp.B = input('Bandwidth (Hz) = ') ; % largeur de bande en Hz
    Xp.T = input('Signal duration (s) = ') ; % duree en secondes
    Xp.class = 'Filtered gaussian noise parameters' ;
end

ftsize = 14 ; % taille des caracteres figure
% nbre d'echantillons
N = Xp.T*Xp.Fs ;
t = linspace(0,Xp.T,N+1) ; 
t = t(1:N) ;
% sequence de bruit blanc
z = randn(1,N) ; 
% filtrage passe-bas
order = 8 ;
% frequence normalisee de coupure (2*B/Fs)
Wn = 2 * Xp.B/(Xp.Fs) ; 
% synthese du filtre passe-bas de Butterworth
[B,A] = butter(order,Wn) ;
[H,F] = freqz(B,A,1024,Xp.Fs) ;
% filtrage sans distorsion
Y = filtfilt(B,A,z) ;
% Application de l'ecart-type
Y = (Y-mean(Y))./std(Y).*Xp.sigma ;
clf,
subplot(211)
plot(t,Y), grid
axis([-Inf Inf -Inf Inf])
xlabel('time (s)','fontsize',ftsize)
ylabel('Amplitude (V)','fontsize',ftsize)
title('Filtered Gaussian Noise','fontsize',ftsize) 
subplot(223)
% non recommande par Matlab avec version R2013a
% Hs = spectrum.welch ;
% set(Hs,'SegmentLength',round(sqrt(N))) ;
% psd(Hs,Y,'Fs',Xp.Fs) ;
% peut etre remplace par ?
subplot(212)
SegmentLength=round(sqrt(N));
Window = hamming(SegmentLength) ;
Nfft = 2^(nextpow2(SegmentLength)+1) ;
noverlap = floor(SegmentLength/2)/SegmentLength ; % AVEC OCTAVE
[PSD,nu]=pwelch(Y,Window,noverlap,Nfft,Xp.Fs,'twosided');
plot(nu,10*log10(PSD))
set(gca,'XLim',[0 Xp.Fs/2])
grid
title('Power Density Spectrum','fontsize',ftsize)
xlabel('Frequency (Hz)','fontsize',ftsize) ;
ylabel('\Gamma_B(f)','fontsize',ftsize)

X.time = t ; 
X.data = Y ;
X.Fs = Xp.Fs ; 