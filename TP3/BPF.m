function [Y,Fp] = BPF(X,Fp)

% [Y,Fp] = BPF(X,Fp) filters the signal structure X with a digital band-pass filter whose 
% parameters are specified in the Fp structure.
% BPF diplays in a single window plot, the zero-pole diagram, the frequency 
% and the impulse responses of the filter, and superimposed, the input and
% the output signals.
%
% Inputs
%
% - X    input signal structure with the following fields:
%           - data : 1-byN vector containing the data samples
%           - time : 1-byN vector containing the time samples
%           - Fs   : scalar indicating the sampling frequency
% - Fp   parameter structure with following fields:
%           - Fs   : scalar indicating the sampling frequency (must be
%           identical to that of X)
%           - F0   : the central frequency (in Hz)
%           - Dnu  : the bandwidth 
%           - order : integer corresponding to the order of the filter 
%           - class : text string indicating the type of the filter.
%
% Outputs
%
% - Y     output signal structure with the following fields:
%           - data : 1-byN vector containing the data samples
%           - time : 1-byN vector containing the time samples
%           - Fs   : scalar indicating the sampling frequency
% - Fp   parameter structure (same as input)
%
% Example:
% Fp = struct('Fs',1000,'F0',100,'Dnu',32,'order',6,'class','BP filter') ;  
% [X,Xp] = CGN() ;
% Y = BPF(X,Fp) ;

% PG : october 2014


ftsize = 14 ; % taille caracteres figures
% test des variables d'entree
% s'il y a 2 variables, on verifie que ce sont bien 2 structures
if nargin == 2
    if ~isstruct(X)
        error('Input ''X'' must be a valid signal structure')
    end
    if ~isstruct(Fp)
        error('Input variable ''Fp'' of BPF.m must be a valid structure')
    end
% s'il n'y en a qu'une, c'est le signal et on doit elaborer celle du filtre
elseif nargin == 1
    Fp = struct ;
    Fp.Fs = input('Sampling frequency (Hz) = ') ;
    while Fp.Fs ~= X.Fs
        warning(['Mismatch with sampling frequency of signal X [',num2str(X.Fs),'Hz]'])
        Fp.Fs = input('Sampling frequency (Hz) = ') ;
    end
    Fp.F0 = input('Central frequency F0 (Hz) = ') ;
    Fp.Dnu = input('Bandwidth around F0 (Hz) = ') ;
    Fp.order = input('Filter order (butterworth) = ') ;
    Fp.class = 'Bandpass filter parameters' ;
end

if Fp.Fs ~= X.Fs
    error('Sampling frequencies mismatch')
end
% Elaboration des frequences de coupure du filtre
Fmin = Fp.F0-Fp.Dnu/2 ;
Fmax = Fp.F0+Fp.Dnu/2 ;
% Multiplication par 2 et division par la frequence d'echantillonnage
Wn = 2*[Fmin Fmax]./Fp.Fs ;
% Synthese du filtre
[B,A] = butter(Fp.order, Wn, 'bandpass') ;
% Calcul et Affichage caracteristiques du filtre
clf,
% diagramme pole-zero
subplot(231)
zplane(B,A) ; grid
% title(['Zero-pole: ',num2str(Fp.order),'-th butterworth bandpass filter'])
title(['Zero-pole (order ',num2str(Fp.order),')'])
% gain complexe
subplot(232)
[H,F] = freqz(B,A,1024,Fp.Fs) ;
plot(F,20*log10(abs(H)),'linewidth',2) ; 
hold on
ymin = min(get(gca,'Ytick')) ; 
ymax = max(get(gca,'Ytick')) ; 
hh = fill([Fmin Fmax Fmax Fmin Fmin],[ymin ymin ymax ymax ymin],'c') ;
set(hh,'linestyle','none','FaceColor',[.8 .8 .8])  
plot(F,20*log10(abs(H)),'linewidth',2) ; 
tt = text(Fp.F0,mean([ymin ymax]),'\Delta\nu ') ;
set(tt,'HorizontalAlignment','center','fontsize',ftsize)
hold off
AddTick('XTick',Fp.F0,'F0')
grid,
xlabel('Frequency (Hz)') 
title(['Freq. response \Delta\nu =',num2str(Fp.Dnu),' Hz']) 
% title(['Band-pass filter - frequency response \Delta\nu =',num2str(Fp.Dnu),' Hz']) 

subplot(233)
[h,t] = impz(B,A) ;
plot(t./Fp.Fs,h) ; grid
xlabel('time (s)')
title(['Impulse response'])
% title(['Impulse response: ',num2str(Fp.order),'-th butterworth bandpass filter'])

y = filtfilt(B,A,X.data) ; 
subplot(212)
plot(X.time,X.data,':k',X.time,y,'r') 
xlabel('time (s)') 
title('Band-pass Filter response')
legend({'Input','Output'})

Y.data = y ;
Y.time = X.time ;
Y.Fs = X.Fs ;
