function [] = AddTick(tick,newtick,newlabel)

% function [] = AddTick(tick,newtick,newlabel)
% Adds a new Tick to the current axis of the actice plot.
% Inputs:
%   tick     : 'XTick', 'YTick' or 'ZTick'
%   newtick  : real number corresponding to be new tick to be added. 'newtick'
%              must be in the range of the current axes extension
%   newlabel : label for the added 'newtick' value 

% PG (CPE 2014)

ticklabel = strcat(tick,'Label') ;
xtick = get(gca,tick) ;
ii = find(abs(xtick-newtick) == min(abs(xtick-newtick)),1,'first') ;
if ii == 1
    xtick = [newtick xtick(2:end)] ;
elseif ii == length(xtick)
    xtick = [xtick(1:end-1) newtick] ;
else
    xtick = [xtick(1:ii-1) newtick xtick(ii+1:end)] ;
end
set(gca,tick,xtick) 
tl = cellstr(get(gca,ticklabel)) ;
tl{ii} = newlabel ;
set(gca,ticklabel,tl) ;
