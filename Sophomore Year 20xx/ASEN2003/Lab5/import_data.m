function [ret_struct] = import_data(filename)
% Purpose: import data given by filename.
% Note: no unit conversons necessary. Data in format:
% Time (s) Omega (rad/s)

% Otherwise, read the file in and format appropriately
data_table = readtable(filename);

% Is this the most optimal solution?
ret_struct.t = table2array(data_table(:,1)) ./ 1000; % import and convert to seconds
ret_struct.omega = table2array(data_table(:,2)) .* (2 * pi) ./ 60; % import and convert to rad/s
ret_struct.name = filename;
end