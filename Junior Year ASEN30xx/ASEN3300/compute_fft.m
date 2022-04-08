function [f,P1] = compute_fft(t,S,Fs)

T = 1/Fs;             % Sampling period       
L = length(S);             % Length of signal

Y = fft(S);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
end