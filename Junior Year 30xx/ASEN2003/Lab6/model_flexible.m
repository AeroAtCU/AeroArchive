function [pos_rad, t_step] = model_flexible(K_1, K_2, K_3, K_4)
% Gains are given

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
%sysTF

% Analyze a step response
t_end = 5; % [s]
[x_step, t_step] = step(sysTF,t_end);

% Do some helpful stuff
theta_d = 0.5;
pos_rad = theta_d * x_step;
end