% ASEN 2003 Lab 6: Rotary Control Lab
% Ian Adler, Max Morgan

% Create the closed loop transfer function
% Variables:
%{
K_ptheta: - proportional gain **K_p**
K_g: ------ gear ratio
K_m: ------ proportional motor constant. relates the speed to the motor voltage
J: -------- moment of inertia about the shaft
R_m: ------ output motor resistance
K_Dtheta: - derivative gain **K_d**
s: -------- laplace variable
%}

clear all; close all;;

% Declare Motor Constants
K_g = 33.3; % [unitless]
K_m = 0.0401; % [V/rad/s]
R_m = 19.2; % [Ohms]
J = 0.0005 + 0.0015; % [Kg*m^2] J = J_hub + J_load
JR_m = J * R_m; % [Ohms * Kg * m^2] For simplicity

% Declare Gains
K_p = .1; % [unitless] proportional 
K_d = .1; % [unitless] derivative (~damping)

% Create the Transfer Function
num = [K_p * K_g * K_m / JR_m];
den = [1, (K_d * K_g * K_m / JR_m), ((K_g^2 * K_m^2 / JR_m) + (K_p * K_g * K_m / JR_m))];

sysTF = tf(num, den);
sysTF

% Analyze a step response
t_end = 5; % [s]
[x_step, t_step] = step(sysTF,t_end);
% x_step is like a percentage

% Compute some helpful stuff
theta_d = 30;
pos_deg = theta_d * x_step;

overshoot = max(pos_deg) - pos_deg(end); % compare highest value to settling value
if overshoot<=0
    overshoot=0;
end
disp(strcat("overshoot: ", num2str(overshoot), " deg"))
%

% Plot simulation
figure; hold on;
plot(t_step, pos_deg)
title("Step Response, K_p=" + K_p + ", K_d=" + K_d)
xlabel("Time [s]")
ylabel("?Theta [deg]?")
%ylim([0, pi])