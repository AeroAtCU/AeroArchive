
%% Horizontal

Ts = 50.5;
Ts_assume = Ts;

k = 0.026065;
v = 1.6215e-5;
Pr = 0.7275;

g = 9.81;
beta = 1/(273 + Ts_assume);
A = 0.15 * 0.2;
Lc = A / (0.15*2 + 0.2*2);
sigma = 5.67e-8;
epsilon = 0.8;

% Declare temp constants
Tinf = 20;
%syms Ts;

% VERTICAL PLATE CALCULATION
Ral = Pr * g*beta*(Ts_assume - Tinf)*Lc^3 / v^2;

nu = 0.27*Ral^0.25;

h = k*nu / Lc;

Qdot_conv = h * A * (Ts - Tinf);
Qdot_rad  = epsilon * sigma * A * ((Ts+273)^4 - (Tinf+273)^4);
Qdot_out = Qdot_conv + Qdot_rad
