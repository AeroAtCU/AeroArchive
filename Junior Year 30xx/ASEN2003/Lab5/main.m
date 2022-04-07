clear all; close all; clc;
data = import_data('9_inches')

% ----- 
l_inches = 9;

I_s = 0.0063; % kg * m^2 SATELLITE
R = 0.076; % m OUTER RADIUS
m = 2 * 0.056; % kg DESPIN MASS, both combined
w_0 = 130 * 2 * pi / 60; % rad/s INITIAL ANGULAR VELOCITY
l = linspace(0,0.3);
mu = 1;

% Define vars from imported data
t = data.t;
w = data.omega;

% ----- Compute Prediction -----
% Omega as a function of time
T1 = (I_s + m * R^2) * w_0;
T2 = -1 * m * R^2 * w_0^3 * t.^2;
T3 = I_s + m * R^2 + m * R^2 * w_0^3 * t.^2;
omega_of_t = (T1 + T2) ./ T3;

% Omega as a function of length
clear T1 T2 T3
T1 = (I_s + m * R^2) * w_0;
T2 = -1 * m * l.^2 * w_0;
T3 = I_s + m * R^2 + m * l.^2;
omega_of_l = (T1 + T2) ./ T3;

% Alpha as a function of time
clear T1 T2 T3
T1 = -1 * m^2 * R^4 * w_0 * t;
T2 = -2 * m^2 * R^4 * w_0^3 * t;
T3 = -2 * I_s * m * R^2 * w_0 * t;
T4 = -2 * I_s * m * R^2 * w_0^3 * t;
T5 = (I_s + m * R^2 + m * R^2 * w_0^2 * t.^2).^2;
alpha_of_t = (T1 + T2 + T3 + T4) ./ T5;

% Alpha as a function of length
clear T1 T2 T3
T1 = -1 * (4 * I_s * m * w_0 * l);
T2 = -1 * (4 * m^2 * R^2 * w_0 * l);
T3 = (I_s + m * R^2 + m * l.^2).^2;     
alpha_of_l = (T1 + T2) ./ T3;

% Tension computation
T_of_t = -1 * I_s * alpha_of_t /  (2 * R);

% Compute Length for Omega == 0
w = 0;
T1 = -1 * (R * w * m + 2 * R * w_0 * m);
T2 = sqrt((R * w * m + 2 * w_0 * m) - 4 * (w * m + w_0 * m) * (I_s * w_0 - R^2 * w * m - I_s * w))
T3 = 2 * (w * m + w_0 * m)
length_omega_zero = (T1 + T2) / T3

% I dislike this method.
%% Plot Omega By Time
figure; hold on;
plot(t, data.omega, 'r.', 'MarkerSize', 10)
plot(t, omega_of_t, 'b.', 'MarkerSize', 10)

legend('9 inch example dataset', 'Predicted Omega', 'Interpreter', 'none')
title(strcat("Measured and Predicted Omega"), 'Interpreter', 'none')
xlabel('Time (s)')
ylabel('Angular Velocity [rad/s]')
hold off

%% Plot Omega by Length
figure; hold on;
plot(l, omega_of_l, '.', 'MarkerFaceColor', 'b', 'MarkerSize', 10)

legend('Predicted Omega', 'Interpreter', 'none')
title(strcat("Predicted Omega by Length"), 'Interpreter', 'none')
xlabel('Length (m)')
ylabel('Angular Velocity [rad/s]')
hold off

%% Plot Alpha By Time
figure; hold on;
plot(t, alpha_of_t, '.', 'MarkerFaceColor', 'r', 'MarkerSize', 10)

legend('Predicted Alpha')
title("Predicted Alpha by Time")
xlabel('Time (s)')
ylabel('Angular Acceleration [rad/s]')
hold off

%% Plot Alpha by Length
figure; hold on;
plot(l, alpha_of_l, '.', 'MarkerFaceColor', 'b', 'MarkerSize', 10)

legend('Predicted Alpha', 'Interpreter', 'none')
title("Predicted Alpha by Length")
xlabel('Length (m)')
ylabel('Angular Acceleration [rad/s^2]')
hold off

%% Plot Tension by Time
figure; hold on;
plot(t, T_of_t, '.', 'MarkerFaceColor', 'b', 'MarkerSize', 10)

legend('Tension', 'Interpreter', 'none')
title("Predicted Tension by Time")
xlabel('Time (s)')
ylabel('Tension [N]')
hold off
