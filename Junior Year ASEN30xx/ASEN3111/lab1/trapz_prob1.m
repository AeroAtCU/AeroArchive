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