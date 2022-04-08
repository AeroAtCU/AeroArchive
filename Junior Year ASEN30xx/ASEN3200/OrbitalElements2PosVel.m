% Ian Adler, ASEN3200
clear all; 
% GIVENS:
h = 20442; % have to compute this manually
e = 0.2; % eccentric anomaly
i = deg2rad(109); % inclination
W = deg2rad(0.15); % big Omega
w = deg2rad(210); % little omega
ta = deg2rad(152.7); % True anomaly 
u = 32930; % mu, km units or whatever they are

% *****DO ANY PROBLEM SPECIFIC CALCULATIONS HERE*****
%{ 
% radius_earth = 6371; % km
alt_p = 300; % km
r_p = alt_p + radius_earth;
a = r_p / (1 - e);
P = a * (1 - e^2);
h = sqrt(P*u); clear radius_earth alt_p%   h COMPUTED
%}

% GET R_x, V_x in PERIFOCAL FRAME
r_x = ((h^2 / u) * (1 / (1 + e*cos(ta)))) .* [cos(ta); sin(ta); 0];
v_x = (u/h) .* [-sin(ta); e+cos(ta); 0];

% Compute QXx and QxX [NOTE: X = (geocentric equatorial), x = x with a bar (perifocal)]
% Multiply a Geo-Equa vector on the RIGHT of this to yield Perifocal coords
Q_Xx = [-sin(W)*cos(i)*sin(w)+cos(W)*cos(w), cos(W)*cos(i)*sin(w)+sin(W)*cos(w),  sin(i)*sin(w);
        -sin(W)*cos(i)*sin(w)-cos(W)*sin(w), cos(W)*cos(i)*cos(w)-sin(W)*sin(w), sin(i)*cos(w);
        sin(W)*sin(i),                       -cos(W)*sin(i),                       cos(i)];

% Multiply a Perifocal matrix on the RIGHT of this to yield Geo-Equa coords
Q_xX = [-sin(W)*cos(i)*sin(w)+cos(W)*cos(w), -sin(W)*cos(i)*cos(w)-cos(W)*sin(w), sin(W)*sin(i);
         cos(W)*cos(i)*sin(w)+sin(W)*cos(w), cos(W)*cos(i)*cos(w)-sin(W)*sin(w), -cos(W)*sin(i);
         sin(i)*sin(w),                      sin(i)*cos(w),                       cos(i)];

% Compute r, v in GEF now
r_X = Q_xX * r_x;
v_X = Q_xX * v_x;

% Display results
disp(strcat("r_x = ", num2str(r_x(1)), "p + ", num2str(r_x(2)), "q +  ", num2str(r_x(3)),      "w   (Position, Perifocal [km])"));
disp(strcat("v_x = ", num2str(v_x(1)), "p + ", num2str(v_x(2)), "q +  ", num2str(v_x(3)),      "w   (Velocity, Perifocal [km/s])"));
disp(strcat("r_X = ", num2str(r_X(1)), "X + ", num2str(r_X(2)), "Y +  ", num2str(r_X(3)),      "Z   (Position, Geo-Equatorial [km])"));
disp(strcat("v_X = ", num2str(v_X(1)), "X + ", num2str(v_X(2)), "Y +  ", num2str(v_X(3)),      "Z   (Velocity, Geo-Equatorial [km/s])"));

