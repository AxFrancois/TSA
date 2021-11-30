function [CharMsg] = Bin2Char(BinMsg,CharLength)

% function [CharMsg] = Bin2Char(BinMsg,CharLength)
% Translates a binary message (BinMsg) into its corresponding character
% string (default is 7 bits ascii code) 
%
% Input:
%   BinMsg : binary vector to be decoded as a string of characters
%   CharLength : Lenght (in bits) of ascii code (default = 7)
%
% Output:
%   CharMsg : string of characters corresponding to BinMsg
%
% See also: Char2Bin

% PG: July 2014

switch nargin
    case 1
        CharLength = 7 ;
end

Nbit = length(BinMsg) ;
Nchar = Nbit / CharLength ;

if Nchar - fix(Nchar) ~= 0
    error(['Size of binary message does not match ASCII code lenght (',num2str(CharLength),')']) ;
end

ByteMsg = reshape(BinMsg, CharLength, Nchar)' ;
CharMsg = '' ;
for k=1:Nchar
    RxChar =  bin2int(ByteMsg(k,:)) ;
    if RxChar == 32, RxChar = 31; end
    CharMsg = strcat(CharMsg,char(RxChar)) ;
end
disp(['Received message ---> ',CharMsg])
