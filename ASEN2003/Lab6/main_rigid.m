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

clear all; clc
try
    sym_import = open("p30d0dot28_symdata.mat");
    sym_t = sym_import.sym_t;
    sym_theta = sym_import.sym_theta;
    clear sym_import
    disp("successful sym import")
catch
    sym_t = 0;
    sym_theta = 0;
    disp("unsuccessful sym import")
end

% Declare Motor Constants
K_g = 33.3; % [unitless]
K_m = 0.0401; % [V/rad/s]
R_m = 19.2; % [Ohms]
J_hub = 0.0005; % Kgm^2
J_load = 0.0015; % I
J = 0.0005 + 0.0015; % [Kg*m^2] J = J_hub + J_load
JR_m = J * R_m; % [Ohms * Kg * m^2] For simplicity

% Declare Gains
K_p = 30; % [unitless] proportional 
K_d = .28; % [unitless] derivative (~damping)

% Create the Transfer Function
num = [0, 0, K_p * K_g * K_m / JR_m];
den = [1, ((K_g^2 * K_m^2 / JR_m) + (K_d * K_g * K_m / JR_m)), (K_p * K_g * K_m / JR_m)];

sysTF = tf(num, den);
sysTF

% Analyze a step response
t_end = 1; % [s]
[x_step, t_step] = step(sysTF,t_end);
% x_step is like a percentage

% Compute some helpful stuff
w_n = sqrt(K_p*K_g*K_m/JR_m);
z = (K_g^2*K_m^2 + K_d*K_g*K_m) / (2*sqrt(K_p*K_g*K_m*JR_m));
zw_n = z*w_n;

theta_d = 0.5;
pos_rad = theta_d * x_step;

overshoot = max(pos_rad) - pos_rad(end); % compare highest value to settling value
if overshoot<=0
    overshoot=0;
end
disp(strcat("overshoot: ", num2str(overshoot), " deg (", num2str((theta_d-overshoot)/theta_d), "%)"))
disp(strcat("w_n: ", num2str(w_n), ""))
disp(strcat("z: ", num2str(z), ""))
disp(strcat("z*w_n: ", num2str(zw_n), " (should be ~20)"))

% Plot simulation
close all;
figure; hold on;
plot(t_step, pos_rad)
plot((sym_t(1001:2001)-1), (sym_theta(1001:2001) + 0.25))
title({"Rigid Arm Step Response"; strcat("overshoot <= ",num2str((theta_d-overshoot)/theta_d,'%4.2f'),"%, ", "settling time <= ",num2str(3/zw_n,'%4.2f'),"s")})
xlabel("Time [s]")
ylabel("Theta [rad]")
plot(linspace(0.15,0.15,10),linspace(theta_d-theta_d*.1,theta_d+theta_d*.1,10),'markerfacecolor','r');

plot(linspace(0.15-0.15*.2,0.15+0.15*.2,10),linspace(theta_d+theta_d*0.05,theta_d+theta_d*0.05,10),'k');
plot(linspace(0.15-0.15*.2,0.15+0.15*.2,10),linspace(theta_d-theta_d*0.05,theta_d-theta_d*0.05,10),'k');


% strcat("K_p=", num2str(K_p), ", K_d=", num2str(K_d));
%annotation('textbox', [0.6, 0.2, 0.2, 0.1], 'String', strcat("overshoot=",num2str((theta_d-overshoot)/theta_d),"%"))
%annotation('textbox', [0.6, 0.1, 0.2, 0.1], 'String', strcat("settling time=",num2str(3/zw_n),"%"))

%ylim([0, pi])
legend("Model Angle", "Experimental Angle","t = 0.15s","theta = +/- 5%",'Location','se')