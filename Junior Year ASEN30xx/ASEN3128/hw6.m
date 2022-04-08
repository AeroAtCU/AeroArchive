% Problem 3
close all; clc; clear all;
t6dot6_nondim_derivs = [-0.8771, -0.2797, 0.1946; 0, -0.3295, -0.04073; 0, 0.304, -0.2737];

u0 = 235.9;
theta0 = 0;
rho = .3045;
S = 511;
b = 59.64

CONST = rho*u0*S; % for cleanliness

t118_dim_derivs = [.5*CONST, .5*CONST*b, .5*CONST*b; .25*CONST, .25*CONST*b^2, .25*CONST*b^2; .25*CONST, .25*CONST*b^2, .25*CONST*b^2;] .* t6dot6_nondim_derivs
%%
% Problem 4%
clc; close all; clear all;
A_lat = [-0.0869, 0, -825, 32.1750;
         -0.0054, -1.1840, 0.335, 0;
         0.0026, -0.021, -0.228, 0;
         0, 1, 0, 0];
     
% Break this down
Yv = A_lat(1,1); 
Yr = A_lat(1,3);
theta0 = atand(deg2rad(A_lat(4,3)));

Lv = A_lat(2,1);
Lp = A_lat(2,2);
Lr = A_lat(2,3);

Nv = A_lat(3,1);
Np = A_lat(3,2);
Nr = A_lat(3,3);

g = A_lat(1,4) / cosd(theta0);
u0 = 825; % ft/sec

% Get some useful things
[V, D] = eig(A_lat); % D diag eigenvalues, V collumns are eigenvalues

% Get Aprox Roll Mode damping
zeta_DR_approx = -(A_lat(1,1) + A_lat(3,3)) / (2*sqrt(A_lat(1,1)*A_lat(3,3) + u0*A_lat(3,1)))
p = [(1) -(Yv+Nr) (Yv*Nr+u0*Nv)];
zeta_roots = roots(p);



% Get Roll mode time constant
lambda_roll_approx = A_lat(2,2);
tau_roll_approx = -1/lambda_roll_approx

% Get spiral mdoe time constant
E = g*(A_lat(2,1)*A_lat(3,3)*cosd(theta0) - A_lat(2,3)*A_lat(3,1)*sind(theta0));
D = -g*(A_lat(2,1)*cosd(theta0) + A_lat(3,1)*sind(theta0)) + u0*(A_lat(2,1)*A_lat(2,3) - A_lat(2,2)*A_lat(3,1));
lambda_spiral_approx = -E/D;
clear E D;
tau_spiral_approx = -1/lambda_spiral_approx

% using an alternative method
C = u0*Nv;
D = u0*(Lv*Np - Lp*Nv) - g*Lv;
E = g*(Lv*Nr - Lr*Nv);
p = [C D E];
CED_roots = roots(p);
lambda_spiral_CED = max(CED_roots);
lambda_roll_CED = min(CED_roots);
tau_spiral_CED = -1/lambda_spiral_CED
tau_roll_CED = -1/lambda_roll_CED