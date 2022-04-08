% Compute radiator area 
epsilon = 0.85;
alpha = 0.2;
sigma = 5.67e-8;
syms A;

% Compute Gsun using 1AU and 1361 avg
r_1au = 1.496e11; % [m]
G_1au = 1361; % [W/m^2]
G_max_au = G_1au * (r_1au^2 / r_p^2);

% Compute Gsun using sigma and T^4
E_sun_bb = sigma * 5800^4;
r_p = (147*10^6) * 10^3; %[m]
r_sun = 6.957e8;
G_max_sigma = E_sun_bb * (r_sun^2 / r_p^2);

G_sun = G_max_au; 


% Compute solar energy @ winter

% Qout computation
Qout = epsilon * A * sigma * (30+273)^4;

% Qin computation
Qsun = alpha * A * G_sun;
Qbackload = 0.85 * A * 88;
Qsensor = 20;
Qheater = 0;

Qin = Qsun + Qbackload + Qsensor + Qheater;

% Solve for Area
eqn = Qin - Qout == 0; % Set up equation
solA = double(solve(eqn, A)); % Solve + convert to #

disp(["Esun@",G_sun])
disp(solA)