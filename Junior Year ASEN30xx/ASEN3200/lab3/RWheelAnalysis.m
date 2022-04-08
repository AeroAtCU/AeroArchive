function [moi] = RWheelAnalysis(rawData, plotTitle)
% Ian Adler
% Purpose: calculate and return the MOI of a reaction wheel.
% raw_data: Nx4 table or array of reaction wheel data
% plot_title: OPTIONAL ARG. If given, plots with title "Rection Wheel Analysis - [plot_title]"

% Declare motor constants:
TorqueConstant = 25.5 / 1000; % [Nm/A] (originally mNm)
% 33.5 for RWHeel, 22.5 for Base motor
rawData = abs(rawData);
% convert data from table to array, if needed
if istable(rawData), rawData = table2array(rawData); end

% Trim raw data to useful linear section.
% All seem to go from 1.5s - 5.5s so hardcoding this in
data = rawData(200:500,:);

% Extract and convert necessary units
t = data(:,1) / 1000; % [s] (originally in ms)
omega = convangvel(data(:,3), 'rpm', 'rad/s'); % [rad/s] (oiriginally in rpm)
actualCurrent = data(:,4); % [A]

% Compute actual torque using motor Torque/Amp value.
actualTorque = actualCurrent .* TorqueConstant; % [Nm]
averageTorque = mean(actualTorque);

% Get the line of best fit and extract the slope (alpha)
coefficients = polyfit(t,omega,1);
alphaAverage = coefficients(1);
bestFitYVals = polyval(coefficients,t);

% Compute the average MOI using Torque = MOI * alpha
moi = averageTorque / alphaAverage; % [kg-m^2] (should be)
disp(strcat("Reaction Wheel MOI ", plotTitle, " ", num2str(moi, '%0.1E'), " kg*m^2"))

% If you want to plot (overkill)
if exist('plotTitle', 'var')
    % Format plot
    figure; hold on;
    title(strcat(plotTitle, " \omega Analysis, MOI = ", num2str(moi, '%0.1E'), " kg*m^2"));
    xlabel('Time [s]');
    ylabel('Angular Velocity \omega [rad/s]');
    
    % Plot raw data, useful data, and line of best fit.
    plot((rawData(:,1) / 1000), convangvel(rawData(:,3), 'rpm', 'rad/s'), 'k'); % Bad practice
    plot(t, omega, 'r', 'LineWidth', 2);
    plot(t, bestFitYVals, '--k');
    
    % legend/ clean up
    legend("Raw \omega","Useful \omega","Average \alpha","location", "southeast");
    hold off;
end

end