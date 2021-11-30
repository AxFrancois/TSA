function [x1, x2, x3, a, b] = SignAleatoires(N,B,m3,sigma3)

sigma1 = 1;
x1 = sigma1 * randn(1,N);
[b,a] = butter(8,B*2);
x2 = filter(b,a,x1);
x3 = sigma3 * x2 + m3;
end