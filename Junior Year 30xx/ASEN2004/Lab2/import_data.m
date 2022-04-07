function [ret_struct] = import_data(filename)

if (filename == "constants" || filename == "constant")
    % Constants for the Golden rocket
    ret_struct.cd = 0.327;
    ret_struct.m_prop = 0.993; % [kg] mass of propellant
    ret_struct.m_dry = 0.121; % [kg] dry mass of rocket
    ret_struct.theta = 45; % [deg] launch angle
    ret_struct.psi = 40.5; % [psi] initial bottle pressure
    ret_struct.heading = 203.5; % [deg] launch heading angle
    ret_struct.wind_surface = 0;
    ret_struct.wing_aloft = 0.44704; % [m/s] 1 mph wind from ENE
    ret_struct.T = 22; %[C] ambient temp
    ret_struct.P = 996.4; %[hPa] ambient pressure
    ret_struct.H = 0.21; % [%/100] ambient humidity
    return
end

data_double = dlmread(filename, '	', 7, 0);
ret_struct.loadcell1 = data_double(:,1) * 4.44822; % [N] converted from lbf
ret_struct.loadcell2 = data_double(:,2) * 4.44822; % [N] converted from lbf
ret_struct.sum = data_double(:,3) * 4.44822; % [N] converted from lbf

% Compute the approximate time of each sample
t = length(ret_struct.loadcell1) / 1652;
ret_struct.t = linspace(0,t,length(data_double(:,1)))'; % generate time matrix
end
