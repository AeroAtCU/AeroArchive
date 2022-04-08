%% cleaning
clc; clear; close all;

%% reading
hardFiles = dir('G10*');
hardData = ReadData(hardFiles);
%MEMS format: Time (s);     Gyro Output (rads/s);   Input Rate (RPM)
%RWHEEL format: Time [ms];	Commanded Torque [mNm];	Angular Velocity [RPM];	Actual Current [Amp];


% Delete the second arg ("RUN...") if you don't want it to plot.
% Get MOI for each test. Could be automated, but no need.
moi(1) = RWheelAnalysis(hardData.G10_Unit05_RWHEEL_RUN1, "RUN 1, 6mNm");
moi(2) = RWheelAnalysis(hardData.G10_Unit05_RWHEEL_RUN2, "RUN 2, 8mNm");
moi(3) = RWheelAnalysis(hardData.G10_Unit05_RWHEEL_RUN3, "RUN 3, 10mNm");

% Do simple analysis on MOI, display results.
moiAvg = mean(moi);
moiStd = std(moi);
disp(strcat("Reaction Wheel MOI average: ", num2str(moiAvg, '%E'), " kg*m^2"))
disp(strcat("Reaction Wheel MOI std:     ", num2str(moiStd, '%E'), " kg*m^2"))
