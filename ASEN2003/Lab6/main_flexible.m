% Main Floppy
% ASEN 2003 Lab 6: Rotary Control Lab
% Ian Adler, Max Morgan

clear all; clc
try
    sym_import = open("flexible_8_2_3_1_symdata.mat");
    sym_t = sym_import.sym_t;
    sym_theta = -sym_import.sym_data;
    sym_deflection = sym_import.sym_deflection;
    clear sym_import
    disp("successful sym import")
catch
    sym_t = 0;
    sym_theta = 0;
    sym_deflection = 0;
    disp("unsuccessful sym import")
end

% Declare Gains
K_1 = 8; % K_ptheta Proportional by theta
K_3 = 2; % K_Dtheta Derivative by theta
K_2 = 3;% K_pd      Proportional by displacement
K_4 = 1; % K_Dd     Derivative by displacement

% Declare Motor Constants
K_g = 33.3; % [unitless]
K_m = 0.0401; % [V/rad/s]
R_m = 19.2; % [Ohms]
J_hub = 0.0005; % Kgm^2
L = 0.45; % m
J_arm = 0.004; % KGm^2
J_M = 0.01;
J_L = J_M + J_arm;
J_load = 0.0015; % I
J = 0.0005 + 0.0015; % [Kg*m^2] J = J_hub + J_load
K_arm = (2*pi*1.8)^2*(J_arm + J_M);

% Compute Other Constants
p_1 = -K_g^2*K_m^2 / (J_hub*R_m);
p_2 = K_g^2*K_m^2*L / (J_hub*R_m);
q_1 = K_arm / (L*J_hub);
q_2 = -K_arm*(J_hub + J_L) / (J_L*J_hub);
r_1 = K_g*K_m / (J_hub*R_m);
r_2 = -K_g*K_m*L / (J_hub*R_m);

lambda_3 = -p_1 + K_3*r_1 + K_4*r_2;
lambda_2 = -q_2 + K_1*r_1 + K_2*r_2 + K_4*(p_2*r_1 - r_2*p_1);
lambda_1 = p_1*q_2 - q_1*p_2 + K_3*(q_1*r_2 - r_1*q_2) + K_2*(p_2*r_1 - r_2*p_1);
lambda_0 = K_1*(q_1*r_2 - r_1*q_2);

% Create the Transfer function
num = [0, 0, K_1*r_1, 0, K_1*(q_1*r_2 - r_1*q_2)];
den = [1, lambda_3, lambda_2, lambda_1, lambda_0];

sysTF = tf(num, den);
sysTF

% Analyze a step response
t_end = 5; % [s]
[x_step, t_step] = step(sysTF,t_end);

% Do some helpful stuff
theta_d = 0.2;
pos_rad = theta_d * x_step;
undershoot = abs(pos_rad(48) - theta_d);
undershoot_percent = 100*undershoot/theta_d;

% Plot the model
figure; hold on;
plot(t_step, pos_rad)
plot(sym_t, sym_theta)
title({"Flexible Arm Step Response";})
xlabel("Time [s]")
ylabel("Theta [rad]")

% Plot some guides
plot(linspace(1,1,10),linspace(theta_d-theta_d*.1,theta_d+theta_d*.1,10),'markerfacecolor','r');

plot(linspace(0.5-1*.2,1+1*.2,10),linspace(theta_d+theta_d*0.1,theta_d+theta_d*0.1,10),'k');
plot(linspace(0.5-1*.2,1+1*.2,10),linspace(theta_d-theta_d*0.1,theta_d-theta_d*0.1,10),'k');
legend("Model Angle", "Experimental Angle","t = 1s","theta = +/- 10%",'Location','se')