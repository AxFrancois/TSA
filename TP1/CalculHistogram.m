function [fx,xout] = CalculHistogram(x, M)

if ~exist('M', 'var')
    sigmax = std(x);
    Valmin = min(x);
    Valmax = max(x);
    M = floor((Valmax - Valmin)/(3.49 * sigmax * length(x)^(-1/3)));
end

[h,xout] = hist(x,M);
if length(x) ~= h
    h = h*1/length(x);
    h = h/trapz(xout,h);
end
mu = mean(x);
%sum(x)/length(x);
sigmax = std(x);
var = std(h);
%var = sqrt(sum(x.^2)/length(x) - (sum(x)/length(x))^2);

%kurtosis(x)
fx = 1/(sigmax * sqrt(2*pi)) * exp(-1/2 * ((xout-mu)/sigmax).^2);

hold on
stem(xout, h)
plot(xout,fx)

end