function [Y] = SquareSig(X)

% [Y] = SquareSig(X)    Computes the square amplitude Y of signal X.
%
% Inputs
% X     Signal structure with fields:
%           - data : 1-by-N vector containing the data samples
%           - time : 1-by-N vector containing the time samples
%           - Fs   : scalar indicating the sampling frequency
%
% Outputs
% Y      Signal structures with fields:
%           - data : 1-by-N vector containing the data samples
%           - time : 1-by-N vector containing the time samples
%           - Fs   : scalar indicating the sampling frequency
%
% Example:
% X = OOK() ;
% Y = SquareSig(X) ;

% PG : octobre 2014 (CPE)

ftsize = 14 ;
switch nargin
    case {0}
        error('Not enough input arguments.')
    case 1
        if ~isstruct(X)
            error('Inputs must be valid signal structures.')
        end
end

Y.data = abs(X.data).^2 ;
Y.time = X.time ;
Y.Fs = X.Fs ;

% clf,
% plot(S.time,S.data,'r',X.time,X.data,':k') ;
% legend({'Squared','Original'})
% title('Signal Squared','fontsize',ftsize) 
% xlabel('time (s)','fontsize',ftsize)
