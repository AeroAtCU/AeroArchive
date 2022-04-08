% Main.m
close all; clear all; clc;

data = load('asen3300mod.mat');
fs = data.fs;
signal = data.signal;
fc = data.fc;

am_demod = demod(signal, fc, fs, 'am');
fm_demod = demod(signal, fc, fs, 'fm');

T = 1/fs;             % Sampling period       
L = length(fm_demod);             % Length of signal
t = (0:L-1)*T;        % Time vector

figure;
plot(t(1:50),fm_demod(1:50))
title('Raw signal')
xlabel('time')
ylabel('signal')

Y = fft(fm_demod);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure;
f = fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')