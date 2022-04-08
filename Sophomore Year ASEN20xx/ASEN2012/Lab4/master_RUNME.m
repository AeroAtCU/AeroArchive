% ASEN2012 Lab 2, Bottle Rocket Lab
% This file runs all functions for calculating the trajectory simple rocket
% inputs: none (not a function)
% outputs: creates plots
% assumptions: gravity constant, no wind, no transition between thrust phases, etc
% Author ID NUMBER
% Author NAME
% Author ID NUMBER
% Author NAME
% Created Nov 22 2018
% Last modified Nov 30 2018

% This file has the following structure:
% -------- Sample Data -------- % Line 22
% --- Find values for (75m) --- % Line 70
% ----- Data Investigation ---- % Line 118

clear all; close all; clc;

% -------------------------------------------- %
% -------------- Sample Data ----------------- %
% -------------------------------------------- %

% Declare times for use in ode45
c.tstep = 0.001;
c.tspan = 0:c.tstep:5;

% Declare test case values:
c.p_abs = 428164.42791;
c.vol_water = 0.001;
c.drag_coeff = 0.5;
c.theta_i = deg2rad(45);
c = calculateConstants(c);

% Find the trajectory
testCase = calcTrajectory(c);

% Make data grabbing easier
testCase.stage1 = testCase.stage1;
testCase.stage2 = testCase.stage2;
testCase.stage3 = testCase.stage3;

% format time data correctly and give max, min height
testCase.stage2.tDataShifted = testCase.stage2.tData + testCase.stage1.tData(end);
testCase.maxHeight = max(testCase.stage3.pos.y);
testCase.maxDistance = max(testCase.stage3.pos.x);

figure; hold on;
axis([0 0.25 0 200]);
title('Thrust vs Time')
set(gca,'FontSize',14)
xlabel('time (s)');
ylabel('Thrust (N)');
plot(testCase.stage1.tData, testCase.stage1.thrustData, '.-b')
plot(testCase.stage2.tDataShifted, testCase.stage2.thrustData, '.-r')
plot([testCase.stage1.tData(end), testCase.stage2.tDataShifted(1)], [testCase.stage1.thrustData(end), testCase.stage2.thrustData(1)], '.-r', 'linewidth', 2.5)
legend('Verification Case Phase 1','Phase 2')

quickplot('Verification Case Height vs Distance');
axis([0 65 0 20])
xlabel(strcat('X (m) (max=', num2str(testCase.maxDistance),')'));
ylabel(strcat('Z (m) (max=', num2str(testCase.maxHeight),')'));
plot(testCase.stage1.pos.x, testCase.stage1.pos.y,'.-b');
plot(testCase.stage2.pos.x, testCase.stage2.pos.y,'.-r');
plot(testCase.stage3.pos.x, testCase.stage3.pos.y,'.-k');
legend('Phase 1','Phase 2','Phase3')

% -------------------------------------------- %
% ---------- Find values for (75m)------------ %
% -------------------------------------------- %

% Declare test case values:
c.p_abs = 428164.42791;
c.vol_water = 0.001;
c.drag_coeff = 0.5;
c.theta_i = deg2rad(45);
c = calculateConstants(c);

% Find maximum allowable pressure
c.p_burst = 1034213.594;
c.FOS = 1.5;
c.p_max_allow = c.p_burst / c.FOS;

tmp = (calcTrajectory(c));
l = tmp.stage3.pos.x(end);
c.p_tol = 1000; % tolerance
for i = 1:150
    disp(num2str(i));
    if l < 75
        c.p_abs = c.p_abs + c.p_tol;
    elseif l> 75
        c.p_abs = c.p_abs - c.p_tol;
    end
    tmp = (calcTrajectory(c));
    l = tmp.stage3.pos.x(end);
end

bestGuess = calcTrajectory(c);
bestGuess.p_abs = c.p_abs;
bestGuess.distance = l;

if (bestGuess.p_abs <= c.p_max_allow)
    fprintf(['Leaving verification case values constant, our pressure of: \n-------- '...
        num2str(bestGuess.p_abs) ...
        'Pa --------\n is sufficient for rocket to reach 75m target accurately.\n']);
    quickplot('Trajectory using best-guess parameters');
    axis([0 80 0 30])
    xlabel(strcat('X (m) (max=', num2str(bestGuess.distance),')'));
    ylabel('Z (m)');
    plot(bestGuess.stage1.pos.x, bestGuess.stage1.pos.y,'.-r');
    plot(bestGuess.stage2.pos.x, bestGuess.stage2.pos.y,'.-g');
    plot(bestGuess.stage3.pos.x, bestGuess.stage3.pos.y,'.-k');
    legend('Phase 1','Phase 2','Phase3')
else
    disp('We must change more parameters. Maximum allowable pressure is not sufficient to bring rocket to 75m target.')
end

% -------------------------------------------- %
% ---------- Data Investigation -------------- %
% -------------------------------------------- %

% Declare test case values:
c.p_abs = 428164.42791;
c.vol_water = 0.001;
c.drag_coeff = 0.5;
c.theta_i = deg2rad(45);
c = calculateConstants(c);

% Calculate how much to change each value by
inv.delta_p_abs = c.p_abs * 0.1;
inv.delta_vol_water = c.vol_water * 0.1;
inv.delta_drag_coeff = c.drag_coeff * 0.1;
inv.delta_theta_i = rad2deg(c.theta_i) * 0.1;
inv.colors = jet;

% plot change in Pressure
quickplot('Effects of Change in Pressure');
for i = 1:5
    invP = strcat( 'p_abs', num2str( i ) );
    c.p_abs = 428164.42791 + (i - 3) * inv.delta_p_abs;
    c = calculateConstants(c);
    inv.(invP) = calcTrajectory(c);
    plot(inv.(invP).stage1.pos.x, inv.(invP).stage1.pos.y, '.-', 'color', inv.colors(i * 10, :), 'LineWidth', 3);
    plot(inv.(invP).stage2.pos.x, inv.(invP).stage2.pos.y, '.-', 'color', inv.colors(i * 10, :), 'LineWidth', 3);
    plot(inv.(invP).stage3.pos.x, inv.(invP).stage3.pos.y, '.-', 'color', inv.colors(i * 10, :), 'LineWidth', 3);
end
c.p_abs = 428164.42791;

% plot change in Theta
quickplot('Effects of Change in Theta')
for i = 1:5
    name = strcat( 'theta_i', num2str( i ) );
    c.theta_i = deg2rad(45 + (i - 3) * inv.delta_theta_i);
    c = calculateConstants(c);
    inv.(name) = calcTrajectory(c);
    plot(inv.(name).stage1.pos.x, inv.(name).stage1.pos.y, '.-', 'color', inv.colors(i * 10, :), 'LineWidth', 3);
    plot(inv.(name).stage2.pos.x, inv.(name).stage2.pos.y, '.-', 'color', inv.colors(i * 10, :), 'LineWidth', 3);
    plot(inv.(name).stage3.pos.x, inv.(name).stage3.pos.y, '.-', 'color', inv.colors(i * 10, :), 'LineWidth', 3);
end
c.theta_i = deg2rad(45);

% plot change in Drag Coefficient
quickplot('Effects of Change in Drag Coefficient')
for i = 1:5
    name = strcat( 'drag_coeff', num2str( i ) );
    c.drag_coeff = 0.5 + (i - 3) * inv.delta_drag_coeff;
    c = calculateConstants(c);
    inv.(name) = calcTrajectory(c);
    plot(inv.(name).stage1.pos.x, inv.(name).stage1.pos.y, '.-', 'color', inv.colors(i * 10, :), 'LineWidth', 3);
    plot(inv.(name).stage2.pos.x, inv.(name).stage2.pos.y, '.-', 'color', inv.colors(i * 10, :), 'LineWidth', 3);
    plot(inv.(name).stage3.pos.x, inv.(name).stage3.pos.y, '.-', 'color', inv.colors(i * 10, :), 'LineWidth', 3);
end
c.drag_coeff = 0.5;

% plot change in Volume
quickplot('Effects of Change in Water Volume')
for i = 1:5
    name = strcat( 'vol_water', num2str( i ) );
    % Saves time by not having to redefine test case data
    c.vol_water = 0.001 + (i - 3) * inv.delta_vol_water;
    c = calculateConstants(c);
    inv.(name) = calcTrajectory(c);
    
    plot(inv.(name).stage1.pos.x, inv.(name).stage1.pos.y, '.-', 'color', inv.colors(i * 10, :), 'LineWidth', 3);
    plot(inv.(name).stage2.pos.x, inv.(name).stage2.pos.y, '.-', 'color', inv.colors(i * 10, :), 'LineWidth', 3);
    plot(inv.(name).stage3.pos.x, inv.(name).stage3.pos.y, '.-', 'color', inv.colors(i * 10, :), 'LineWidth', 3);
end
c.vol_water = 0.001;

clear i l tmp
