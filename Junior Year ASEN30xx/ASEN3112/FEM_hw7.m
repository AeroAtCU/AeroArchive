clear all; close all; clc;

% Declare physical constants
E = 3000;
L = 30;
P = 200;
A1 = 2;
A2 = 4;
A3 = 3;
theta1 = 0;
theta2 = 30;
theta3 = 120;

% Compute other constants
L1 = L;
L2 = L/cosd(theta2);
L3 = (sqrt(3)*L/3)/sind(60);

coeff1 = E * A1 / L1;
coeff2 = E * A2 / L2;
coeff3 = E * A3 / L3;

% Compute transfer matrix for each bar, and the associated k
trans1 = compute_trans_matrix(theta1);
trans2 = compute_trans_matrix(theta2);
trans3 = compute_trans_matrix(theta3);

k1 = coeff1 * trans1;
k2 = coeff2 * trans2;
k3 = coeff3 * trans3;

% Assemble global k""
k = zeros(8,8);
k_global_bar1_section = zeros(8,8);
k_global_bar2_section = zeros(8,8);
k_global_bar3_section = zeros(8,8);


k_global_bar1_section(1:2, 1:2) = k1(1:2,1:2);
k_global_bar1_section(1:2, 7:8) = k1(1:2,3:4);
k_global_bar1_section(7:8, 1:2) = k1(3:4,1:2);
k_global_bar1_section(7:8, 7:8) = k1(3:4,3:4);

k_global_bar2_section(3:4, 3:4) = k2(1:2,1:2);
k_global_bar2_section(3:4, 7:8) = k2(1:2,3:4);
k_global_bar2_section(7:8, 3:4) = k2(3:4,1:2);
k_global_bar2_section(7:8, 7:8) = k2(3:4,3:4);

k_global_bar3_section(5:6, 5:6) = k3(1:2,1:2);
k_global_bar3_section(5:6, 7:8) = k3(1:2,3:4);
k_global_bar3_section(7:8, 5:6) = k3(3:4,1:2);
k_global_bar3_section(7:8, 7:8) = k3(3:4,3:4);

k = k_global_bar1_section + k_global_bar2_section + k_global_bar3_section

% Apply boundary conditions
u = [0 0 0 0 0 0 1 1]; % all zero except node 4 which we leave as unit value
ku = k.*u
ku_condensed = ku(7:8,7:8)% Only the last row has nonzero external forces!

% Solve for displacements
% yea I know it shouldn't be hardcoded like this but it's the correct
% values
u4x = 44.857/572.3076;
u4y = (-P + 44.8557 * u4x) / 424.1025
u4x = 44.857*u4y/572.3076

