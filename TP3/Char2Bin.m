function [BinMsg] = Char2Bin(CharMsg,CharLength)

% function [BinMsg] = Char2Bin(CharMsg,CharLength)
% Encripts a string message (CharMsg) into its corresponding binary
% vector (code default is 7 bits ascii) 
%
% Input:
%   CharMsg : string of characters to be encripted as a binary vector
%
% Output:
%   BinMsg : Binary vector corresponding to encripted CharMsg
%
% See also: Bin2Char

% PG: July 2014

switch nargin
    case 1
        CharLength = 7 ;
end

Nchar = length(CharMsg) ;
msgint = uint8(CharMsg) ;  
msgbin = dec2bin(msgint)' ;
BinMsg = str2num(msgbin(:))' ; 

