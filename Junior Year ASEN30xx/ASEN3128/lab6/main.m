close all; clc; clear all;
t187_nondim_derivs = [-0.8771, -0.2797, 0.1946; 0, -0.3295, -0.04073; 0, 0.304, -0.2737];

W = (6.366*10^5)*4.448;%N
m = W/9.81; %kg
theta0 = 0; %rad
S = 5500*(0.3048^2); %m^2
u0 = 518*0.3048; %m/s
rho = 0.6601; %kg/m^3
c = 27.31*0.3048; %m
b = 195.68*0.3048; %m

m = rho*u0*S; % for cleanliness

t188_dim_derivs = [.5*m, .5*m*b, .5*m*b; .25*m, .25*m*b^2, .25*m*b^2; .25*m, .25*m*b^2, .25*m*b^2;] .* t187_nondim_derivs