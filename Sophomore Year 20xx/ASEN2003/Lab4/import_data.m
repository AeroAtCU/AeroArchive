function [ret_struct] = import_data(filename)
% Purpose: import data given by filename.
% Note: no unit conversons necessary. Data in format:
% Time (s) Theta (rad) Omega (rad/s)
if (filename == "constants" || filename == "constant")
    % Special case to define constants.
    % Just wanted to reduce clutter in main
    
    ret_struct.r_d = 0.235; % [m] radius of disk
    ret_struct.r_p = 0.178; % [m] radius to extra mass
    ret_struct.r_of_p = 0.019; % [m] radius OF extra mass
    ret_struct.r_pp = ret_struct.r_of_p; % [m] radius OF extra mass
    
    ret_struct.m_supp = 0.7; % [kg] mass of supports
    ret_struct.m_s = ret_struct.m_supp; % [kg] mass of supports
    ret_struct.m_p = 3.4; % [kg] mass of extra mass
    ret_struct.m_d = 11.7; % [kg] mass of disk
    
    ret_struct.k = 0.203; % [m] radius of gyration
    ret_struct.g = 9.81; % [m/s^2] gravitational accelration
    ret_struct.beta = deg2rad(5.5); % [rad]
    ret_struct.M0 = -1.5; % some moment thing, not mass
    return
end

% Otherwise, read the file in and format appropriately
data_table = readtable(filename);

% Is this the most optimal solution?
ret_struct.t = table2array(data_table(:,1));
ret_struct.theta = table2array(data_table(:,2));
ret_struct.omega = table2array(data_table(:,3));
ret_struct.name = filename;
end