function [dt_b12, dt_b23, dt_end, height_b1, h_0] = import_trackerdata()
% Outputs the normal array except the first value is the tracker
% data (where applicable).

% Load normal data (had to do this to smoothly integrate with
% the pre-written analysis code. Sub optimal solution, but a
% solution nonetheless.
load('bounce_data.mat');

% TRACKER 1 import:
disp("Loading Tracker 1")
tracker1_data = readtable(strcat("Tracker 1.txt"));

dt_end(1) = table2array(tracker1_data(end,'t'));
height_b1(1) = abs(table2array(tracker1_data(14,'x')));
t1_h = abs(table2array(tracker1_data(1,'x')));

% TRACKER 2 import:
disp("Loading Tracker 2")
tracker2_data = readtable(strcat("Tracker 2.txt"));

dt_end(2) = table2array(tracker2_data(end,'t'));
height_b1(2) = abs(table2array(tracker2_data(13,'x')));
t2_h = abs(table2array(tracker2_data(1,'x')));

% TRACKER 3 import:
disp("Loading Tracker 3")
tracker3_data = readtable(strcat("Tracker 3.txt"));

dt_end(3) = table2array(tracker3_data(end,'t'));
height_b1(3) = abs(table2array(tracker3_data(14,'x')));
t3_h = abs(table2array(tracker3_data(1,'x')));

% Calculate an average start height (it just is this way)
h_0 = mean([t1_h, t2_h, t2_h]);

% Trim the tables. settin = [] did not work, so here we are.
dt_b12 = dt_b12(1:3,:);
dt_b23 = dt_b23(1:3,:);
dt_end = dt_end(1:3,:);
height_b1 = height_b1(1:3,:);
end