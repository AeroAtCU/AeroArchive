% Ian Adler, ASEN3200
%clear all; clc
% Pg 218, 197
% LIST YOUR GIVENS: in earth centered thing
r = r_X;
v = v_X;
%u = 32930; % mu, km units
u = 6.319 * 10^10;

disp(strcat("///GIVEN: r_x = ", num2str(r(1)), "x + ", num2str(r(2)), "y +  ", num2str(r(3)),      "z   (Position [km]) /// ", "v_x = ", num2str(v(1)), "x + ", num2str(v(2)), "y +  ", num2str(v(3)),      "z   (Velocity [km/s])"));

% RADIAL VELOCITY
v_r = dot(r, v) / norm(r);

% SPECIFIC ANGULAR MOMENTUM
h = cross(r, v);
% h = cross(r,e) / norm(cross(r,e)) % alternatively

% INCLINATION
i = acos(h(3) / norm(h));

%This vector defines the node line.
N = cross([0 0 1], h);

% RIGHT ASCENSION OF THE ASCENDING NODE
if N(2) >= 0
    W = acos(N(1) / norm(N));
else
    W = 2*pi - acos(N(1) / norm(N));
end

% ECCENTRICITY
e = (1 / u) * ((norm(v)^2 - u/norm(r)) .* r - norm(r) * v_r .* v);

% ARGUMENT OF PERIGEE
if e(3) >= 0
    w = acos(dot((N / norm(N)), (e / norm(e))));
else
    w = 2*pi -acos(dot((N / norm(N)), (e / norm(e))));
end

% TRUE ANOMALY
if v_r >= 0
    ta = acos(dot((e / norm(e)), (r / norm(r))));
else
    ta = 2*pi - acos(dot((e / norm(e)), (r / norm(r))));
end

% Calculations for a:
eg = (u^2 * (norm(e)^2 - 1)) / (2 * norm(h)^2);
a = abs(u / (2*eg));

% FLIGHT PATH ANGLE
y = atan((norm(e)*sin(ta))/(1+norm(e)*cos(ta)));

% PERIOD
P = 2*pi*sqrt(a^3/u);

% ECCENTRICITY
E0 = 2*atan((sqrt((1-norm(e))/(1+norm(e))))*tan(ta/2));
M0 = E0 - norm(e)*sin(E0);
n = 2*pi/P
t0 = M0 / n;

% Format and display outputs
disp(strcat("v_r = ", num2str(v_r), "      (Radial Velocity)"));
disp(strcat("a = ", num2str(a), "      (a)"));
disp(strcat("h = ", num2str(norm(h)), "      (specific angular momentum)"));
disp(strcat("e = ", num2str(norm(e)), "      (eccentricity)"));
disp(strcat("i = ", num2str(rad2deg(i)), "      (inclination [deg])"));
disp(strcat("W = ", num2str(rad2deg(W)), "      (right ascension of the ascending node [deg])"));
disp(strcat("w = ", num2str(rad2deg(w)), "      (argument of perigee [deg])"));
disp(strcat("ta = ", num2str(rad2deg(ta)), "      (true anomaly [deg])"));
disp(strcat("eg = ", num2str(eg), "      (energy [energy])"));
disp(strcat("y = ", num2str(rad2deg(y)), "      (flight path angle [deg])"));%}
disp(strcat("P = ", num2str(P), "      (Period [s])"));%}

disp(strcat("E0 = ", num2str(rad2deg(E0)), "      (Eccentric Anomaly [deg, @ta0])"));%}
disp(strcat("M0 = ", num2str(rad2deg(M0)), "      (Mean Anomaly [deg, @ta0])"));%}
disp(strcat("t0 = ", num2str(t0), "      (Time since Periapsis [s])"));%}
disp(strcat("E0 = ", num2str(rad2deg(E0)), "      (Eccentric Anomaly [deg, @ta0])"));%}



if v_r > 0 disp("///Satellite is flying away from perigee."), elseif v_r < 0 disp("///Satellite is flying toward perigee"), else disp("///Radial Velocity Zero"), end;


%% IGNORE // DELETE
r_X = r;
v_X = v;

Q_Xx = [-sin(W)*cos(i)*sin(w)+cos(W)*cos(w), cos(W)*cos(i)*sin(w)+sin(W)*cos(w),  sin(i)*sin(w);
        -sin(W)*cos(i)*sin(w)-cos(W)*sin(w), cos(W)*cos(i)*cos(w)-sin(W)*sin(w),  sin(i)*cos(w);
        sin(W)*sin(i),                       -cos(W)*sin(i),                      cos(i)];

Q_xR = [cos(ta) sin(ta) 0;
        -sin(ta) cos(ta) 0;
        0 0 1];
    
    
r_x = Q_Xx * r_X;
v_x = Q_Xx * v_X;

r_r = Q_xR * r_x;
v_r = Q_xR * v_x;

M1 = n*(t0 + 3*60*60);
E1 = SolveKepler(M1,norm(e));
tanew = 2*atan(sqrt((1+norm(e))/(1-norm(e)))*tan(E1/2))
% slide 28, lec6





function E_n1 = SolveKepler(M,e)
% Get initial guess
E_n = M + e * sin(M);

% Run until E_n+1 is within 1% of E_n
for i = 1:25
    E_n1 = M + e * sin(E_n);
end
end
