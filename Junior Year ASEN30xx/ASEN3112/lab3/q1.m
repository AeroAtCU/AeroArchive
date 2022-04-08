% List givens
clc
n = 398600 / 42164^3
r2 = [-10; 10; 0]; % column matrix
ro = [0;0;0];

t = 2*60*60;
phi_rr = [4-3*cos(n*t) 0 0; 6*(sin(n*t)-n*t) 1 0; 0 0 cos(n*t)];
phi_rv = [(1/n)*sin(n*t) (2/n)*(1-cos(n*t)) 0; 2/n*(cos(n*t)-1) 1/n*(4*sin(n*t)-3*n*t) 0; 0 0 1/n*sin(n*t)];

v2 = -1 * inv(phi_rv) * r2


