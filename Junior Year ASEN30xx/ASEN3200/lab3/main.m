% main
clear all; close all;

filenames_list = ".\rw\Unit7_Base_"+(5:10);
titlenames_list = "Base "+(5:10);

for i = 1:length(filenames_list)
    data_arr = import_data(filenames_list(i));
    RWheelAnalysis(data_arr, titlenames_list(i));
    
    filename = strcat(titlenames_list(i), '.png');
    saveas(1,filename)
end

%%
% Import REAL data
pd15 = import_data('.\g10\group_10_section_012_1');
pd25 = import_data('.\g10\group_10_section_012_2');

pd15(1,:) = [];
pd25(1,:) = [];

% Plot K_p = 15
close all; figure; hold on;
title("Trail 1, K_p = 100, K_d = 1"); xlabel("time [ms]"); ylabel("rad");
plot(pd15(:,1),pd15(:,3))
plot(pd15(:,1),pd15(:,2), '--')
legend("Measured Position", "Reference Position")

% Ploto K_p = 25
figure; hold on;
title("Trial 2, K_p = 100, K_d = 1"); xlabel("time [ms]"); ylabel("rad");
plot(pd25(:,1),pd25(:,3))
plot(pd25(:,1),pd25(:,2), '--')
legend("Measured Position", "Reference Position")


%%

% Import OTHER data
pd15 = import_data('.\other\spin_module_kp_71_kd_25.txt');
pd25 = import_data('.\other\spin_module_kp_93_kd_32.txt');

pd15(1,:) = [];
pd25(1,:) = [];

% Plot K_p = 15
close all; figure; hold on;
title("Step Response, K_p = 71, K_d = 25"); xlabel("time [ms]"); ylabel("rad");
plot(pd15(:,1),pd15(:,3), 'b')
plot(pd15(:,1),pd15(:,2), '--')
legend("Measured Position", "Reference Position")

% Ploto K_p = 25
figure; hold on;
title("Step Response, K_p = 93, K_d = 32"); xlabel("time [ms]"); ylabel("rad");
plot(pd25(:,1),pd25(:,3), 'b')
plot(pd25(:,1),pd25(:,2), '--')
legend("Measured Position", "Reference Position")

%%
% Import REAL data
pd15 = import_data('.\g10\group_10_section_012_1');
pd25 = import_data('.\g10\group_10_section_012_2');

pd15(1,:) = [];
pd25(1,:) = [];

% Plot K_p = 15
close all; figure; hold on;
title("Trail 1, K_p = 100, K_d = 1"); xlabel("time [ms]"); ylabel("rad");
plot(pd15(:,1),pd15(:,3))
plot(pd15(:,1),pd15(:,2), '--')
legend("Measured Position", "Reference Position")

% Ploto K_p = 25
figure; hold on;
title("Trial 2, K_p = 100, K_d = 1"); xlabel("time [ms]"); ylabel("rad");
plot(pd25(:,1),pd25(:,3))
plot(pd25(:,1),pd25(:,2), '--')
legend("Measured Position", "Reference Position")
%%

function [data] = import_data(filename)
file_path = filename;
data_table = readtable(file_path);
data = table2array(data_table);
end

