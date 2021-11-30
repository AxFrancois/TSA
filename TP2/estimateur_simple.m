function [gamma1,f,N] = estimateur_simple(bruit,nd,nf,N_points);


sequence = bruit(nd:nf);
Y = fft(sequence,N_points);
N = nf-nd+1;
delta_f = 1/N_points;
f = 0:delta_f:1-delta_f;
gamma1  = (abs(Y)).^2/N_points;

end


