clear all; close all; clc;
% Check our panel thing is working
Nmax = 100;
XXXX = 4415;
c = 1;
alpha = deg2rad(8);

close all;
storage = nan(Nmax,2);

% ===================================================================
% P2: For AOA = 0, compute flow for different resolutions and compare
N_to_test = [11 13 23 27 35 37 41 47 98 100 ];
storage_flow_resolutions = zeros(length(N_to_test), 4);
tic
for i = 1:length(N_to_test)
    [x, y] = compute_NACA_points(0012, 1, N_to_test(i));
    [cl, ~, ~] = Vortex_Panel(x, y, nan, 0);
    storage_flow_resolutions(i,1) = N_to_test(i);
    storage_flow_resolutions(i,2) = real(cl);
end
% Error Analysis
storage_flow_resolutions(:,3) = abs([diff(storage_flow_resolutions(:,2)); 0]);
storage_flow_resolutions(:,4) = 100 - abs(100 * (storage_flow_resolutions(:,2) - storage_flow_resolutions(:,3)) ./ storage_flow_resolutions(:,2));

t1 = toc;
figure; hold on; title("NACA 0012 Panel Resolution Study (AOA=0)");
xlabel("Number of panels"); ylabel("cl value");
plot(storage_flow_resolutions(:,1), storage_flow_resolutions(:,2), '*-b', 'linewidth', 2, 'markersize', 8)
plot(storage_flow_resolutions(:,1), storage_flow_resolutions(:,3), '*-r', 'linewidth', 2, 'markersize', 8)
legend("Actual c\_l", "Change in c\_l")

% Thus we can settle on 100 being a safe (within 10% error)
N_nominal = 100;
trim = storage_flow_resolutions(1:end-1,:);
%disp("Panel Study Results:")
%disp("   N Panels   cl        change   Percent Error")
%disp(trim);
disp(strcat("-> N_Nominal = ", string(N_nominal), " and yields < 10% error"))

% ===================================================================
% P2: Using nominal N, plot results of AOA = multiple
AOA_to_test = deg2rad([-5 0 5 10 15]);
tic
storage_cl_vals = zeros(length(AOA_to_test),2);
figure; hold on; title("NACA 0012 at changing AOA - C_P"); xlabel("x [m]"); ylabel("C_P")
for i = 1:length(AOA_to_test)
    [x, y] = compute_NACA_points(0012, 1, N_nominal);
    [cl, cp, ~] = Vortex_Panel(x, y, nan, AOA_to_test(i));
    plot(x(1:end-1), cp);
    storage_cl_vals(i,1) = AOA_to_test(i);
    storage_cl_vals(i,2) = cl;
end


figure; hold on; title("NACA 0012 at changing AOA - C_l");  xlabel("AOA [deg]"); ylabel("C_l")
plot(rad2deg(storage_cl_vals(:,1)), storage_cl_vals(:,2), '*', 'markersize', 10);

% ===================================================================
% P3: Sectional lift coefficient vs AOA
AOA_to_test = deg2rad([-5 0 5 10 15]);
storage_0012 =  zeros(length(AOA_to_test),2);
for i = 1:length(AOA_to_test)
    [x, y] = compute_NACA_points(0012, 1, N_nominal);
    [cl, ~, ~] = Vortex_Panel(x, y, nan, AOA_to_test(i));
    storage_0012(i,1) = AOA_to_test(i);
    storage_0012(i,2) = cl;
end

storage_2412 =  zeros(length(AOA_to_test),2);
for i = 1:length(AOA_to_test)
    [x, y] = compute_NACA_points(2412, 1, N_nominal);
    [cl, ~, ~] = Vortex_Panel(x, y, nan, AOA_to_test(i));
    storage_2412(i,1) = AOA_to_test(i);
    storage_2412(i,2) = cl;
end

for i = 1:length(AOA_to_test)
    [x, y] = compute_NACA_points(4412, 1, 55);
    [cl, ~, ~] = Vortex_Panel(x, y, nan, AOA_to_test(i));
    storage_4412(i,1) = AOA_to_test(i);
    storage_4412(i,2) = cl;
end
storage_2424 =  zeros(length(AOA_to_test),2);
for i = 1:length(AOA_to_test)
    [x, y] = compute_NACA_points(2424, 1, 55);
    [cl, ~, ~] = Vortex_Panel(x, y, nan, AOA_to_test(i));
    storage_2424(i,1) = AOA_to_test(i);
    storage_2424(i,2) = cl;
end

asdf = 5;
figure; title("Thick Airfoil C_l vs Alpha"); xlabel("AOA [deg]"); ylabel("cl [dimensionless]"); 
hold on;
plot(rad2deg(storage_0012(:,1)),storage_0012(:,2), '*', 'linewidth', asdf)
plot(rad2deg(storage_2412(:,1)),storage_2412(:,2), '*', 'linewidth', asdf)
plot(rad2deg(storage_4412(:,1)),storage_4412(:,2), '*', 'linewidth', asdf)
plot(rad2deg(storage_2424(:,1)),storage_2424(:,2), '*', 'linewidth', asdf)
plot([-5 15], [pi*(-5)/90-1, pi*(15)/90-1])
legend("0012", "2412", "4412", "2424", "Thin Airfoil")

% COmpute lift slope
ls_0012 = (storage_0012(2) - storage_0012(1)) / 5;
ls_2412 = (storage_2412(2) - storage_2412(1)) / 5;
ls_4412 = (storage_4412(2) - storage_4412(1)) / 5;
ls_2424 = (storage_2424(2) - storage_2424(1)) / 5;
disp(strcat("Lift Slope NACA 0012 = ", num2str(ls_0012)));
disp(strcat("Lift Slope NACA 2412 = ", num2str(ls_2412)));
disp(strcat("Lift Slope NACA 4412 = ", num2str(ls_4412)));
disp(strcat("Lift Slope NACA 2424 = ", num2str(ls_2424)));