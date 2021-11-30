function [ormin,ormax]=tracord(x);
mi=min(x);
Ma=max(x);
if mi<0
	ormin=1.1*mi;
elseif mi==0
	ormin=0;
elseif mi>0
	ormin=0.9*mi;
end;
if Ma<0
	ormax=0.9*Ma;
elseif Ma==0
	ormax=0;
elseif Ma>0
	ormax=1.1*Ma;
end;
