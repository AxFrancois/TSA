function [S,Sp,M] = OOK(Sp)

% [S,Sp,M] = OOK(Sp)     Generates a ON-OFF keying modulated signal whose
% parameters are specified by the parameter structure Sp
% S(n) = M(n).A.cos(2.pi.Fc.n/Fs + phi)
% M(n) is either a binary periodic signal (0-1) oscillating at frequency FM
% or a 0-1 sequence defined by W (if specified W overides FM). OOK.m
% displays in the current window plot the synthesised signal.
%
% Inputs:
% Sp     signal structure containing the signal parameters with following fields: 
%           - Fs    sampling frequency of the signal (in Hz)
%           - A     amplitude of the carrier
%           - Fc    carrier frequency (in Hz)
%           - FM    modulating frequency (0 = no modulation) (in Hz)
%           - T     duration of the signal (in seconds)
%           - W     binary word to be transmitted (overides periodic modulation)
%           - Phi   initial phase of the carrier (r.v. unif dist. over (0,2\pi))
%           - Class String defining the type of signal S
%        If varargin is left empty, each field of 'Sp' is defined online
%
% Outputs:
% S     signal structure containing the synthesised OOK signal with fields:
%           - data : 1-byN vector containing the data samples
%           - time : 1-byN vector containing the time samples
%           - Fs   : scalar indicating the sampling frequency
% 
% Sp    parameter structure (same as input)
% M     signal structure containing the Modulant signal (same structure as S) 
%   
%
% Example :
%       Sp = struct('Fs',50e3,'A',2,'Fc',1e3,'FM',5e1,'Phi',0,'T',1e-1,'W',[])
%       [S,Sp,M] = OOK(Sp) 
%       plot(S.time,S.data,M.time,M.data,':r')
% or
%       [S,Sp] = OOK() 

% PG : octobre 2014 (CPE)


if nargin == 1
    if ~isstruct(Sp)
        error('Input variable of OOK.m must be a valid structure')
    end
else
    Sp = struct ;
    Sp.A = input('Amplitude (V) = ') ;
    Sp.Fs = input('Sampling frequency (Hz) = ') ;
    Sp.Fc = input('Carrier frequency (Hz) = ') ;
    Sp.FM = input('Modulating frequency (Hz) = ') ;
    Sp.T = input('Signal duration (s) = ') ;
    Sp.W = input('Binary word [0/1 stream] = ') ;
    Sp.Phi = rand*2*pi ;
    Sp.class = 'OOK signal parameters'
end

ftsize = 14 ;

N = Sp.T*Sp.Fs ;
t = linspace(0,Sp.T,N+1) ; 
t = t(1:N) ;
P = Sp.A*sin(2*pi*t*Sp.Fc + Sp.Phi) ;
if isempty(Sp.W) 
    m = (sin(2*pi*t*Sp.FM) >=0 ) ;
else
    pad = ceil(N/length(Sp.W)) ;
    m = repmat(Sp.W,pad,1) ;
    m = m(:)' ; 
    m = m(1:N) ;
end
s = P.*m ;

clf
plot(t,s)
axis([0 Sp.T 1.2*[-Sp.A Sp.A]])
xlabel('time (s)','fontsize',ftsize)
ylabel('Amplitude (V)','fontsize',ftsize)
title('ON-OFF keying modulated signal','fontsize',ftsize) 


S.time = t ; 
S.data = s ;
S.Fs = Sp.Fs ;

M.time = t ; 
M.data = m ;
M.Fs = Sp.Fs ;

