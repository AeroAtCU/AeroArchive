% Solve Kepler's equation iteratively - Ian Adler
% Declare initial conditions
M = pi/6
e = 0.00001
E_n = M; % Assume

% Get initial guess
E_n1 = M + e * sin(E_n);

% Run until E_n+1 is within 1% of E_n
while abs(E_n1 - E_n) > 0.01
    E_n1 = M + e * sin(E_n);
end
disp(strcat("E = ", num2str(E_n1)))