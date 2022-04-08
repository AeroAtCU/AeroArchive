% Ian Adler
% ASEN3128
% MainProb1.m
% Created: 22Jan2021
clc; clear all; close all;
tspan = linspace(0, 1.98, 100); % time span, duration 1 second
initial_conditions = [0.1; -0.1; 0.1]; % intial conditions [unitless]

tmp1 = 1;

[t, pos_vec] = ode45(@(t, pos_vec) ODEFUNProb1(pos_vec, tmp1), tspan, initial_conditions);

figure;
title("Problem 1")
subplot(3,1,1)
plot(t, pos_vec(:,1))
title("x positions vs time")

subplot(3,1,2)
plot(t, pos_vec(:,2))
title("y positions vs time")

subplot(3,1,3)
plot(t, pos_vec(:,3))
title("z positions vs time")

