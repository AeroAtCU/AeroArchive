function xdot = objectEOM(t, x, rho, Cd, A, m, g, wind)
% Ian Adler
% ASEN3128
% objectEOM.m
% Created: 22Jan2021
% Decompose Input vector:
pos = x(1:3); % Extract position
vel = x(4:6) + wind; % Extract velocity and add wind

% Factor in drag force
F_drag = calcDrag(vel, rho, Cd, A);

% Factor in gravity
F_grav = [0; 
          0; 
          m * g];

% Sum Forces
F_sum = F_grav + F_drag;

% Compute net accelerations
acc = F_sum ./ m;

% Stop condition and output
if pos(3) >0
    xdot = [0;0;0;0;0;0];
else
    xdot = [vel; acc];
end
end