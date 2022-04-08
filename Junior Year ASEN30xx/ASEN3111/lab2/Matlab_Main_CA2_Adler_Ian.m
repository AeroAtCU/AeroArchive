% Ian Adler
% This plots a variety of graphs relating to flower over a wing modeled by
% a freestream combined with a variable intensity vortex sheet. Feb 26
% Help from Lucas Pereira

clear all;clc;clf;close all; tic;

% Declare Constants
xmin=-10;
xmax=10;
ymin=-5;
ymax=5;
gridpoints=100; % size of SQUARE gridpoint
% Create meshgrid that all flowfield characteristic will be computed at
[x,y]=meshgrid(linspace(xmin,xmax,gridpoints),linspace(ymin,ymax,gridpoints));

% Compute "Gold Standard" - High number of N's which we call exact solution
% format is: (c, AOA_deg, v_inf, x, y, gridpoints, N,   output_type);
N = 300;
exact = compute_flowfield_characteristics(5, 20, 50, x, y, gridpoints, N, 'struct');
exact = analyze_rms(exact);

num_panels = [1:N]';
cp_pct_difference = nan(N,1);
v_pct_difference = nan(N,1);
 
vel_array = nan(N,1);

for i = 3:N
    approx = compute_flowfield_characteristics(5, 10, 50, x, y, gridpoints, i, 'struct');
    approx = analyze_rms(approx);
    cp_pct_difference(i) = 100 * abs(approx.cp_rms - exact.cp_rms) / exact.cp_rms;
    v_pct_difference(i) = 100 * abs(approx.v_rms - exact.v_rms) / exact.v_rms;
end

% Compare differences in c, AOA, V_inf keeping all others constant
c_2dot5 = compute_flowfield_characteristics(2.5, 10, 50, x, y, gridpoints, N, 'struct');
c_10 = compute_flowfield_characteristics(10, 10, 50, x, y, gridpoints, N, 'struct');

AOA_5 = compute_flowfield_characteristics(5, 5, 50, x, y, gridpoints, N, 'struct');
AOA_20 = compute_flowfield_characteristics(5, 20, 50, x, y, gridpoints, N, 'struct');

v_inf_25 = compute_flowfield_characteristics(5, 10, 25, x, y, gridpoints, N, 'struct');
v_inf_100 = compute_flowfield_characteristics(5, 10, 100, x, y, gridpoints, N, 'struct');


% =====================
% ===== Plots =========
% =====================
% Plots basic thing
Plot_Airfoil_Flow(5, 10, 50, 101.3*10^3, 1.225, 100);

% Plot and Display Error convergence
figure; 
plot(num_panels, cp_pct_difference, '.', 'linewidth', 3);
xlabel("N Vortices"); ylabel("Percent Difference From Solution [%]");
title("Cp Accuracy vs number of vortices");

figure; 
plot(num_panels, v_pct_difference, '.', 'linewidth', 3);
xlabel("N Vortices"); ylabel("Percent Difference From Solution [%]");
title("Velocity Accuracy vs number of vortices");

fprintf("Exact cp value, computed with N = 300 Vortices:      cp = %f\n", exact.cp_rms)
fprintf("Velocity mean value, computed with N = 300 Vortices: v  = %f m/s\n", exact.v_rms)

% Plot differences when changing c
figure; hold on;
title("Effects of changing chord length c"); hold on;
subplot(3,2,1);
contourf(x,y,c_2dot5.stream_matrix,10); hold on;
plot([c_2dot5.x_eval_points(1), c_2dot5.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Streamlines: c = 2.5 (0.5x default)")

subplot(3,2,3);
contourf(x,y,exact.stream_matrix,10); hold on;
plot([exact.x_eval_points(1), exact.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Streamlines: c = 5 (default)")

subplot(3,2,5);
contourf(x,y,c_10.stream_matrix,10); hold on;
plot([c_10.x_eval_points(1), c_10.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Streamlines: c = 10 (2x default)")


subplot(3,2,2);
contourf(x,y,c_2dot5.equipotential_matrix,20); hold on;
plot([c_2dot5.x_eval_points(1), c_2dot5.x_eval_points(end)],[0 0], 'k', 'linewidth',3)
title("Equipotential: c = 2.5 (0.5x default)")

subplot(3,2,4);
contourf(x,y,exact.equipotential_matrix,20); hold on;
plot([exact.x_eval_points(1), exact.x_eval_points(end)],[0 0], 'k', 'linewidth',3)
title("Equipotential: c = 5 (default)")

subplot(3,2,6);
contourf(x,y,c_10.equipotential_matrix,20); hold on;
plot([c_10.x_eval_points(1), c_10.x_eval_points(end)],[0 0], 'k', 'linewidth',3)
title("Equipotential: c = 10 (2x default)")



% Plot differences when changing AOA ==========================
figure; title("Effects of changing AOA"); hold on;
subplot(3,2,1);
contourf(x,y,AOA_5.stream_matrix,10); hold on;
plot([AOA_5.x_eval_points(1), AOA_5.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Streamlines: AOA = 5 (0.5x default)")

subplot(3,2,3);
contourf(x,y,exact.stream_matrix,10); hold on;
plot([exact.x_eval_points(1), exact.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Streamlines: AOA = 10 (default)")

subplot(3,2,5);
contourf(x,y,AOA_20.stream_matrix,10); hold on;
plot([AOA_20.x_eval_points(1), AOA_20.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Streamlines: AOA = 20 (2x default)")


subplot(3,2,2);
contourf(x,y,AOA_5.equipotential_matrix,20); hold on;
plot([AOA_5.x_eval_points(1), AOA_5.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Equipotential: AOA = 5 (0.5x default)")

subplot(3,2,4);
contourf(x,y,exact.equipotential_matrix,20); hold on;
plot([exact.x_eval_points(1), exact.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Equipotential: AOA = 10 (default)")

subplot(3,2,6);
contourf(x,y,AOA_20.equipotential_matrix,20); hold on;
plot([AOA_20.x_eval_points(1), AOA_20.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Equipotential: AOA = 20 (2x default)")

% Plot differences when changing v_inf ===================================
figure; title("Effects of changing freestream velocity v_inf"); hold on;
subplot(3,2,1);
contourf(x,y,v_inf_25.stream_matrix,10); hold on;
plot([v_inf_25.x_eval_points(1), v_inf_25.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Streamlines: v = 25 (0.5x default)")

subplot(3,2,3);
contourf(x,y,exact.stream_matrix,10); hold on;
plot([exact.x_eval_points(1), exact.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Streamlines: v = 50 (default)")

subplot(3,2,5);
contourf(x,y,v_inf_100.stream_matrix,10); hold on;
plot([v_inf_100.x_eval_points(1), v_inf_100.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Streamlines: v = 100 (2x default)")


subplot(3,2,2);
contourf(x,y,v_inf_25.equipotential_matrix,20); hold on;
plot([v_inf_25.x_eval_points(1), v_inf_25.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Equipotential: v = 25 (0.5x default)")

subplot(3,2,4);
contourf(x,y,exact.equipotential_matrix,20); hold on;
plot([exact.x_eval_points(1), exact.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Equipotential: v = 50 (default)")

subplot(3,2,6);
contourf(x,y,v_inf_100.equipotential_matrix,20); hold on;
plot([v_inf_100.x_eval_points(1), v_inf_100.x_eval_points(end)],[0 0], 'k', 'linewidth',1)
title("Equipotential: v = 100 (2x default)")
toc