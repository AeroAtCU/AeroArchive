% Ian Adler
% April 6 2021
% Purpose: run PLLT on the test case from lecture 14 page 6
%   to verify funcitonality. After all the parameters were
%   properly set, it produces the exact same results.
clc
clear all
b_span = 40; % span

a0_t = 2*pi; % this is the only part that's weird. actually, no
a0_r = 2*pi; % the lift slope for thin airfoil theory is just 2pi.
% But it's confusing cause this was assumed in the lecture and carried thru

c_t = 5; %cord
c_r = 5;

aero_t = 0; % zero lift AOA (zero for TAT)
aero_r = 0;

geo_r = 5; % Actual angle of attack
geo_t = 5;

N=2; % number of terms used

[e, cl, cd] = PLLT(b_span,   a0_t,  a0_r,  c_t, c_r, aero_t, aero_r, geo_r, geo_r, N, [pi/2; pi/3])
% answers are e = 97911, cl = 0.40537, cdi = 0.0066778