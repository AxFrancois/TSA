function [S] = AddSig(X,Y)

% [S] = AddSig(X,Y) Computes the sum Z of the two signals X and Y.
%
% Inputs
% X, Y  Signal structures with fields:
%           - data : 1-by-N vector containing the data samples
%           - time : 1-by-N vector containing the time samples
%           - Fs   : scalar indicating the sampling frequency
%       X and Y must have same lenghths and same sampling frequencies
%
% Outputs
% Z      Signal structures with fields:
%           - data : 1-by-N vector containing the data samples
%           - time : 1-by-N vector containing the time samples
%           - Fs   : scalar indicating the sampling frequency

% PG : octobre 2014 (CPE)
       

ftsize = 14 ;
switch nargin
    case {0,1}
        error('Not enough input arguments.')
    case 2
        if ~isstruct(X) | ~isstruct(Y)
            error('Inputs must be valid signal structures.')
        end
end

if length(X.time) ~= length(Y.time)
    error('Mismatch input lenghts.')
end
if X.Fs ~= Y.Fs
    error('Mismatch sampling frequencies.')
end

S.data = X.data + Y.data ;
S.time = X.time ;
S.Fs = X.Fs ;

% subplot(311)
% plot(X.time,X.data,'k')
% title('Signal X','fontsize',ftsize) 
% xlabel('time (s)','fontsize',ftsize)
% subplot(312)
% plot(Y.time,Y.data,'k')
% title('Signal Y','fontsize',ftsize) 
% xlabel('time (s)','fontsize',ftsize)
% subplot(313)
% plot(S.time,S.data,'b','linewidth',2)
% title('Signal S=X+Y','fontsize',ftsize) 
% xlabel('time (s)','fontsize',ftsize)

       