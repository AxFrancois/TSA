function [N] = bin2int(b)

% function [N] = bin2int(b)
% Converts a binary sequence 'b' to its decimal (integer) value. 
        
weight = 2.^([length(b)-1:-1:0]) ;
N = sum(b.*weight) ;
