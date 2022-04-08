function vel_vec = ODEFUNProb1(pos_vec, tmp1)
% Ian Adler
% ASEN3128
% ODEFUN.m
% Created: 22Jan2021

%pos_vec in form [x; y; z]
%vel_vec in form [xdot; ydot; zdot;

% Extract x, y, z positions for readability
x = pos_vec(1);
y = pos_vec(2);
z = pos_vec(3);

% Compute derivative from given equations
xdot = x + 2*y + z;
ydot = x - 5*z;
zdot = x*y - y^2 + 3 * z^3;

% Format output
vel_vec = [xdot; ydot; zdot];
end