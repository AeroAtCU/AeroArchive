function [ret_struct] = IMPORTDATA(filename)
% Purpose: import data given by filename.

% read file in
data_table = readtable(filename);

% parse the table 
ret_struct.t = table2array(data_table(2:end,1));
ret_struct.gyro_output = table2array(data_table(2:end,2));
ret_struct.input_rpm = table2array(data_table(2:end,3));
end
