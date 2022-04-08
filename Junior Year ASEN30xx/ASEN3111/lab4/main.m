% Matlab_Main_CA4_Adler
% Ian Adler / April 2021
disp("running")

clear all; close all; clc;

%% Problem 2
[b_span,   a0_t,  a0_r,  c_t, c_r, aero_t, aero_r, geo_t, geo_r, N] = deal...
(100,      6.892, 6.881, 5,   15,  0,      -2.148, 0,     5,     10);

% Allocate and determine values
N_terms = 100;
prob2.e = nan(N_terms,1);
prob2.cl = nan(N_terms,1);
prob2.cd = nan(N_terms,1);
prob2.N = nan(N_terms,1);

% Compute cl, cd for an increasing number of terms
for i = 2:N_terms
    [prob2.e(i), prob2.cl(i), prob2.cd(i)] = PLLT(b_span,   a0_t,  a0_r,  c_t, c_r, aero_t, aero_r, geo_t, geo_r, i);
    prob2.N(i) = i;
end

% Compute actual lift and drag (not coeffs)
v = 220; % [ft/s, not mph)
A = (c_t + c_r) *100 / 2;
rho =  0.00237; % slug/ft^3
prob2.L = prob2.cl * rho * v^2 * A / 2000;
prob2.D = prob2.cd * rho * v^2 * A / 2000;

% Compute the % difference in values for cl, cd
prob2.L_error = abs(diff(prob2.L)*100) ./ prob2.L(2:end);
prob2.D_error = abs(diff(prob2.D)*100) ./ prob2.D(2:end);

% Find smallest N to get desired percent change
prob2.L_10pct = get_closest_idx(prob2.L_error, 10);
prob2.L_1pct =  get_closest_idx(prob2.L_error, 1);
prob2.L_0point1pct = get_closest_idx(prob2.L_error, 0.1);

prob2.D_10pct = get_closest_idx(prob2.D_error, 10);
prob2.D_1pct =  get_closest_idx(prob2.D_error, 1);
prob2.D_0point1pct = get_closest_idx(prob2.D_error, 0.1);

% Print required results
fprintf("Problem 2, Lift:\n")
fprintf("    N odd terms for 10%%  relative error: %d\n", prob2.L_10pct)
fprintf("    N odd terms for 1%%   relative error: %d\n", prob2.L_1pct)
fprintf("    N odd terms for 0.1%% relative error: %d\n", prob2.L_0point1pct)
fprintf("Problem 2, Drag:\n")
fprintf("    N odd terms for 10%%  relative error: %d\n", prob2.D_10pct)
fprintf("    N odd terms for 1%%   relative error: %d\n", prob2.D_1pct)
fprintf("    N odd terms for 0.1%% relative error: %d\n", prob2.D_0point1pct)

% Plot Problem 2
if true
    figure; title("Problem 2 - Convergence of Cl, Cd"); xlabel("N odd terms"); ylabel("Force [kip]"); hold on;
    plot(prob2.N, prob2.L, 'bo');
    plot(prob2.N, prob2.D, 'ro');
    plot(prob2.N, prob2.L, 'b.');
    plot(prob2.N, prob2.D, 'r.');
    legend("Lift", "Drag")
end

%% Problem 3
a0_t = 2*pi;
a0_r = 2*pi;
aero_t = 0;
aero_r = 0;
geo_t = 5;
geo_r = 5;
N=25;

AR = [4 6 8 10];
c_r = 15;
ratio = linspace(0.01, 1, 100);
c_t = ratio*c_r;

AR4.b_span = 4*c_r*(ratio+1)/2;
AR6.b_span  = 6*c_r*(ratio+1)/2;
AR8.b_span  = 8*c_r*(ratio+1)/2;
AR10.b_span  = 10*c_r*(ratio+1)/2;

for i = 1:length(ratio)
    [AR4.e(i), ~, ~] = PLLT(AR4.b_span(i),   a0_t,  a0_r,  c_t(i), c_r, aero_t, aero_r, geo_t, geo_r, N);
    [AR6.e(i), ~, ~] = PLLT(AR6.b_span(i),   a0_t,  a0_r,  c_t(i), c_r, aero_t, aero_r, geo_t, geo_r, N);
    [AR8.e(i), ~, ~] = PLLT(AR8.b_span(i),   a0_t,  a0_r,  c_t(i), c_r, aero_t, aero_r, geo_t, geo_r, N);
    [AR10.e(i), ~, ~] = PLLT(AR10.b_span(i),   a0_t,  a0_r,  c_t(i), c_r, aero_t, aero_r, geo_t, geo_r, N);
end

figure; title("Problem 3 - Span Efficiency vs Taper Ratio"); xlabel("Taper Ratio (c_t / c_r)"); ylabel("Span Efficiency Factor (e)"); hold on;
plot(ratio, AR4.e, 'linewidth', 2)
plot(ratio, AR6.e, 'linewidth', 2)
plot(ratio, AR8.e, 'linewidth', 2)
plot(ratio, AR10.e, 'linewidth', 2)
legend("AR=4", "AR=6", "AR=8", "AR=10");

function closest_value = get_closest_value(source, value)
[closest_value, ~] = min(abs(source - value));
end

function idx = get_closest_idx(source, value)
[~, idx] = min(abs(source - value));
end