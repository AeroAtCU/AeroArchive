function [ret_struct] = IMPORTDATA(filename, convert)
% Purpose: import data given by filename.
% NOTE: also reformats all units into standard metric.
% Create system-dependant path to the file

% Convert to cm
if(convert)
    scaling = 0.01;
else
    scaling = 1;
end

% read file in
data_table = readtable(filename);

% Is this the most optimal solution?
ret_struct.t = table2array(data_table(:,1));
ret_struct.wheel_pos = table2array(data_table(:,2));
ret_struct.slide_pos = scaling * table2array(data_table(:,3));
ret_struct.wheel_speed = table2array(data_table(:,4));
ret_struct.slide_speed = scaling * table2array(data_table(:,5));
ret_struct.actual_t = scaling .* table2array(data_table(:,6));
end
