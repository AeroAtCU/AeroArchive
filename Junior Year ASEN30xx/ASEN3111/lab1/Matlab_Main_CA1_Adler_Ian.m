% ASEN 3111 - Computational Assignemnt 01 - Main
% We are tasked with computing the lift generated from a vortex (spinning
% cylinder in inviscid flow) as well as approximating the lift over a NACA
% airfoil using a trapezoidal sum. We also look at now the number of panels
% (similarly, pressure measurements) effect error.
%
% Author: Ian Adler
% Collaborators:
% Date: 01 Feb 2021

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% PROBLEM #1 - Rotating Cylinder %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear all; close all; tic;
disp("<Program Start>")

% Declare symbolic variables we will use
syms theta

% Define given pressure function, pre-simplified by dividing T out
% Also define the cl and cd equation, in their base form (no integrals)
cl(theta) = -0.5* (4*sin(theta) - 4*sin(theta)^2) *sin(theta);
cd(theta) = -0.5* (4*sin(theta) - 4*sin(theta)^2) *cos(theta);

% ------------------------------
% Analytically compute cl and cd
% ------------------------------
cl_analytical = double(int(cl, 0, 2*pi)); % perform integration
cd_analytical = double(int(cd, 0, 2*pi));

% ------------------------------
% Approximate (TRAPEZOID RULE) cl and cd
% ------------------------------
max_N_panels = 6; % declaring some vector to store data
cl_approx = nan(max_N_panels, 1);
cd_traps = nan(max_N_panels, 1);
cl_simps = nan(max_N_panels, 1);
cd_simps = nan(max_N_panels, 1);
N = 1:max_N_panels;

min_N_traps = max_N_panels;
min_N_simps = max_N_panels;
target_0p1percent = 0.001*cl_analytical; % required cl value for 0.1% accuracy

% run through computation of different values
for i = 1:max_N_panels
    cl_approx(i) = trapz_symbolic(cl, i, 0, 2*pi);
    cd_traps(i) = trapz_symbolic(cd, i, 0, 2*pi);
    cl_simps(i) = simps_symbolic(cl, i, 0, 2*pi);
    cd_simps(i) = simps_symbolic(cd, i, 0, 2*pi);
    
    % If the percent error is less than our required ammount...
    if abs((cl_approx(i) - cl_analytical) / cl_analytical) <= 0.001
        % and if the current number of panels is bigger than this new, but
        % still proper, estimate...
        if min_N_traps > i
            min_N_traps = i; % change the number of panels required
        end
    end
    
    if abs((cl_simps(i) - cl_analytical) / cl_analytical) <= 0.001
        if min_N_simps > i
            min_N_simps = i;
        end
    end
end
disp(cl_approx)
% produce plots
figure; hold on; title("Problem 1 - Trapezoidal Approximation");
xlabel("Number of Panels"); ylabel("Coefficient Value [unitless]");
plot(N, cd_traps, 'r', 'linewidth', 2)
plot(N, cl_approx, 'b', 'linewidth', 2);
legend("cd", "cl")

figure; hold on; title("Problem 1 - Composite Simpson's Approximation");
xlabel("Number of Panels"); ylabel("Coefficient Value [unitless]");
plot(N, cd_simps, 'r', 'linewidth', 2)
plot(N, cl_simps, 'b', 'linewidth', 2);
legend("cd", "cl")

% Print required results
fprintf("-------- Problem 1 - Rotating Cylinder --------\n");
fprintf("Analytically determined value:\n    cl = %g\n    cd = %g\n", cl_analytical, cd_analytical);
fprintf("Number of panels for 1/10%% relative error (cl), Trapezoid rule: N = %g\n", min_N_traps);
fprintf("Number of panels for 1/10%% relative error (cl), Composite Simpson's rule: N = %g\n\n", min_N_simps);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% PROBLEM #2 - NACA airfoil %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
load Cp.mat

% Declare constants
alpha = deg2rad(9); % Angle of attack [rad]
c = 1.5; %chord length[m]
V_inf = 40; %[m/s]
rho_inf = 1.225; %[kg/m^3]pay
p_inf = 101.3*10^3; %[pa]
t = 12; % naca xx value
q_inf = 0.5 * p_inf * V_inf^2;  

% ----------------------------------------------------
% Analytically approximate cl and cd with high N count
% ----------------------------------------------------
N = 1000; % Number of panels (technically half the number of panels, bc N is used for top and bottom)
xvals = linspace(0, c, N + 1); % Generate array of x values to use
dx = c / N; % Compute length of each trap

% Compute cn using equation 1.15 (cf=0 b/c inviscid)
% the spline takes values in x/c
yvals = fnval(Cp_lower, xvals/c) - fnval(Cp_upper, xvals/c); % vector of values of whatever function we want to approximate over
cn = (1/c) * trapz_vector(yvals, dx); % use the y values and base width to approximate area under curve

% Compute ca using equation 1.16 (cf=0 b/c inviscid)
y_t = compute_NACA_values(xvals, c, t); % get vector of y heights of the airfoil
dy_upper = [y_t(2:N+1), 0] - y_t; % get dy. Basically just subtract each value from it's value to the right, with 0 @ the end
dy_lower = -dy_upper; % Same values, just opposite direction (symetric airfoil).
yvals = (dy_upper / dx) .* fnval(Cp_upper, xvals/c) - (dy_lower / dx) .* fnval(Cp_lower, xvals/c); % eqn 1.16
ca = (1/c) * trapz_vector(yvals, dx);

% Convert from airfoil frame to body frame
cl_analytical = cn*cos(alpha) - ca*sin(alpha);
cd_analytical = cn*sin(alpha) + ca*cos(alpha);
Lprime_analytical = cl_analytical*c*0.5*V_inf^2; % from equationn on page 25
Dprime_analytical = cd_analytical*c*0.5*V_inf^2; % NOT: p_inf cancels out
% NOTE p_inf cancels out because basically it's carried through the
% trapezoidal sum process and then divided out by the L' and D' equations.
%   1) cp = p - p_inf / q_inf
%        = p / q_inf <-- We get cp from the graphs and use it to find cl
%  2) L' = cl * q_inf * c <-- it cancles out here
%        = cl * c
% It works out
 
% ---------------------------------------------------
% Approximate cl and cd and find N for relative error
% ---------------------------------------------------
max_N_panels = N; % Closest possible value will be whatever we used to get out analytical value
% (Make this ^^^ high enough so 1/10% relative error requirement is met)
Lprime_approx = nan(max_N_panels, 1); % hold all our approximated cl values

min_N_5percent = max_N_panels;
min_N_1percent = max_N_panels;
min_N_0p1percent = max_N_panels;

% run through computation of different values
% Only lightly commented because it's just a looped implementation of above
for i = 1:max_N_panels
    xvals = linspace(0, c, i + 1); % Generate array of x values to use
    dx = c / i; % Compute length of each trap
    
    yvals = fnval(Cp_lower, xvals/c) - fnval(Cp_upper, xvals/c); % vector of values of whatever function we want to approximate over
    cn = (1/c) * trapz_vector(yvals, dx); % use the y values and base width to approximate area under curve
    
    y_t = compute_NACA_values(xvals, c, t); % get vector of y heights of the airfoil
    dy_upper = [y_t(2:i+1), 0] - y_t; % get dy. Basically just subtract each value from it's value to the right, with 0 @ the end
    dy_lower = -dy_upper; % Same values, just opposite direction (symetric airfoil).
    yvals = (dy_upper / dx) .* fnval(Cp_upper, xvals/c) - (dy_lower / dx) .* fnval(Cp_lower, xvals/c); % eqn 1.16
    ca = (1/c) * trapz_vector(yvals, dx);
    
    % Convert from airfoil frame to body frame
    cl_approx = cn*cos(alpha) - ca*sin(alpha);
    Lprime_approx(i) = cl_approx*c*0.5*V_inf^2; % from equationn on page 25

    % Basically how this works is we assume that it takes the full number
    % of panels, N, to compute the approximation. But if we happen to run
    % into a smaller N, where it still computes an acceptable value, then
    % we set our minimum N to that. This is an alternative to simply
    % storing all the values and finding the min N later, or having a
    % boolean that flips when the first accepted N is reached. This works.
    if abs((Lprime_approx(i) - Lprime_analytical) / Lprime_analytical) <= 0.05 % .05 is 5%
        if min_N_5percent > i % And it requires less panels to get this fine approx...
            min_N_5percent = i; % change the number of panels required
        end
    end
    
    if abs((Lprime_approx(i) - Lprime_analytical) / Lprime_analytical) <= 0.01 % .01 is 1%
        if min_N_1percent > i
            min_N_1percent = i; % change the number of panels required
        end
    end
    
    if abs((Lprime_approx(i) - Lprime_analytical) / Lprime_analytical) <= 0.001 % .001 is 1/10%
        if min_N_0p1percent > i
            min_N_0p1percent = i; % change the number of panels required
        end
    end
end

% Print necessary outputs
% Multiplying N by two because "total n umber of panels" is twice the number
% of trapezoids on the top or bottom (which is what N means in my code)
fprintf("-------- Problem 2 - NACA0012 --------\n");
fprintf("Analytically approximated Lift and Drag per unit span:\n    L' = %g\n    D' = %g\n", Lprime_analytical, Dprime_analytical);
fprintf("Number of panels for 5%% relative error of N': N = %g\n", (min_N_5percent*2));
fprintf("Number of panels for 1%% relative error of N': N = %g\n", (min_N_1percent*2));
fprintf("Number of panels for 1/10%% relative error of N': N = %g\n\n", (min_N_0p1percent*2));

disp("<Program End>")
toc

%figure; hold on; title("cl Approximation of NACA0012");
%xlabel("Number of Panels"); ylabel("Coefficient Value [unitless]");
%plot(1:max_N_panels, cl_approx, 'r', 'linewidth', 2)
%legend("cl")


function area = trapz_vector(yvals, dx)
% Author: Ian Adler
% Collaborators:
% Date: 01 Feb 2021

% Purpose: approximate area under a curve using Trapezoidal rule. Pure
% vector implementation of trapz_symbolic but with vector instead of sym.

% yvals: vector of y values to sum over
% dx: length of each trap base

% Compute approximate area of each trap.
traps_area = (dx * (yvals(1:end-1) + yvals(2:end))) ./ 2; % Compute area of each trap, width * (y1+y2)/2

% Sum area of each trap to get total area (approx. integral)
area = sum(traps_area);
end

function area = simps_symbolic(equation, N, start_x, end_x)
% Author: Ian Adler
% Collaborators:
% Date: 01 Feb 2021

% Purpose: approximate area under a curve using Composit Simpson's rule

% equation: symbolic of the function to approximate
% N: number of panels. 2N+1 = number of yvalues needed
% interval: the interval on which to approximate

% Compute necessary parameters (length, height)
xvals = linspace(start_x, end_x, 2*N+1); % Generate array of x values of each thing
h = (end_x - start_x) / (2*N); % some constant
rolling_sum = 0;
% Easier to do a for loop for this one.
for k = 1:N
    f_x2km1 = double(subs(equation, xvals(2*k - 1)));
    f_x2k = double(subs(equation, xvals(2*k)));
    f_x2kp1 = double(subs(equation, xvals(2*k + 1)));
    rolling_sum = rolling_sum + (f_x2km1 + 4*f_x2k + f_x2kp1);
end

area = (h/3) * rolling_sum;
end

function area = trapz_symbolic(equation, N, start_x, end_x)
% Author: Ian Adler
% Collaborators:
% Date: 01 Feb 2021

% Purpose: approximate area under a curve using Trapezoidal rule

% equation: symbolic of the function to approximate
% n: number of panels. n+1 = number of yvalues needed
% interval: the interval on which to approximate

% Compute necessary parameters (length, height)
xvals = linspace(start_x, end_x, N + 1); % Generate array of x values of each trap
dx = (end_x - start_x) / (N); % Compute length of each trap
yvals = double(subs(equation, xvals)); % Compute height of each trap at each value of x

% Compute approximate area of each trap.
traps_area = (dx * (yvals(1:N) + yvals(2:N+1))) ./ 2; % Compute area of each trap width * (y1+y2)/2

% Sum area of each trap to get total area (approx. integral)
area = sum(traps_area);
end