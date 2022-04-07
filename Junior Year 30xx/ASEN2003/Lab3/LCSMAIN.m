% Ian Adler
% ASEN2003 
% Purpose: ?

clear all; close all; clc;
% Define some constants
r = 0.762; % [cm]
d = 1.524; % [cm]
l = 2.54; % [cm]

voltage = '5';
filename = strcat('Test1_',voltage,'pt5V');

% Grab the data. True -> convert to cm 
data = IMPORTDATA(filename, true);

% Compute the actual wheel position (required)
[data.actual_wheel_pos,~,~] = LCSDATA(filename);

% Use the model
data.slide_speed_model = LCSMODEL(r, d, l, ...
    data.wheel_pos, data.wheel_speed);

% "Residuals"
data.residuals = data.slide_speed_model - data.slide_speed;
data.error_mean = mean(data.residuals);
data.error_std = std(data.residuals);

disp(strcat(num2str(voltage),"V mean of difference: ",num2str(data.error_mean)));
disp(strcat(num2str(voltage),"V std of difference: ",num2str(data.error_std)));

% Plots
LCSPLOT(data,strcat(voltage,'V5'),'theta')
% saveas(gcf,strcat(voltage,'V5_theta.png'))
% close all
LCSPLOT(data,strcat(voltage,'V5'),'residuals')
% saveas(gcf,strcat(voltage,'V5_residuals.png'))
% close all
% LCS_plot(data,title,'time')