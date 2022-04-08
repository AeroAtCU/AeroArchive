% Ian Adler
% ASEN3128
% MainProb2.m
% Created: 22Jan2021

clc; clear all; close all;
tspan = linspace(0, 4, 100); % time span, duration 30 seconds

pos_initial = [0; 0; 0];
vel_initial = [0; 20; -20]; % NED frame, 20m/s up and 20m/s east
x_initial = [pos_initial; vel_initial];

wind = [5; 0; 0]; % initial wind

% declare constants:
m = 0.03; % [kg]
d = 0.03; % [m]
A = pi * (d/2)^2; % [m^2}
Cd = 0.6;
g = 9.8;
rho = 1.225; % [kg/m^3]

x_deflection = nan(10,1);

%figure; title("X deflection vs wind speed"); xlabel("time [s]"); ylabel("x position [m]");
%hold on;
for i = 1:10
    wind = [1*i; 0; 0];
    [t, x] = ode45(@(t, x) objectEOM(t, x, rho, Cd, A, m, g, wind), tspan, x_initial);
    x_deflection(i) = x(1,end);
end



% Decompose x
pos = x(:,1:3); % Extract position
vel = x(:,4:6); % Extract velocity

figure;
title("Problem 2")
subplot(3,1,1)
plot(t, pos(:,1))
title("x position vs time")

subplot(3,1,2)
plot(t, pos(:,2))
title("y positions vs time")

subplot(3,1,3)
plot(t, pos(:,3))
title("z positions vs time")
