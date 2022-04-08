% Modified version to only analyze the Tracker data.
clear all
use_tracker = true;

if (~use_tracker)
    load('bounce_data.mat');
    h_0 = 12.75; % in
else
    [dt_b12, dt_b23, dt_end, height_b1, h_0] = ...
        import_trackerdata();
end

clear tnum tracker_data
close all;

% Define constants
g = 386.09; % in/s^2
fall_time = sqrt(2*h_0/g);

% Compute coeff of restitution e, store in a struct
height_of_bounce.e = (height_b1 ./ h_0) .^ (1/2);

time_of_bounce.e = (dt_b23 ./ dt_b12);

time_to_stop.e = (dt_end - sqrt((2 * h_0) / g)) ./...
    (dt_end + sqrt((2 * h_0) / g));

% Extract some simple stats like mean, median, std etc.
height_of_bounce = get_e_stats(height_of_bounce);
time_of_bounce = get_e_stats(time_of_bounce);
time_to_stop = get_e_stats(time_to_stop);

% Create Basic Plot
figure; hold on;
%plot(time_of_bounce.e);
plot(height_of_bounce.e);
plot(time_to_stop.e);


title('Coefficient of Restitution using Digital Tracking Software');
xlabel('Trial No');
ylabel('e [unitless]');
hold off

% Extract Calculations
eH_std = height_of_bounce.std;
eT_std = time_of_bounce.std;
eS_std = time_to_stop.std;

e_height = height_of_bounce.e;

%% Error Propogation

%Height of Bounce Error
de_dh = 1./(2*e_height*h_0);
de_dh_pre = h_0./(2*e_height*h_0^2);
de_height = sqrt((de_dh).^2 * 0.25^2 + (de_dh_pre).^2 * 0.25^2);
de_height_mean = mean(de_height);

% Time of Bounce Error
de_dt = 1./dt_b12;
de_dt_pre = -1 * dt_b23 ./ (dt_b12).^2;
de_time = sqrt((de_dt).^2 * .05^2 + (de_dt_pre).^2 * .05^2);
de_time_mean = mean(de_time);

% Time of Stop Error
de_ds = (dt_end - fall_time)./(dt_end + fall_time).^2 + 1./(fall_time + dt_end);
de_dh0 = -1*(dt_end - fall_time)./(g*fall_time*(dt_end + fall_time).^2) - 1./(g*fall_time*(dt_end+fall_time));
de_stop = sqrt((de_ds).^2 * 0.1^2 + (de_dh0).^2 * 0.1^2);
de_stop_mean = mean(de_stop);

% Sumation of Error & Weight
de_total = de_height_mean + de_time_mean + de_stop_mean;
height_dif = de_total - de_height_mean;
time_dif= de_total - de_time_mean;
stop_dif = de_total - de_stop_mean;
total_dif = height_dif + time_dif + stop_dif;
height_weight = height_dif / total_dif;
time_weight = time_dif / total_dif;
stop_weight = stop_dif / total_dif;

% Final E with Weighted Averages
e_final = height_of_bounce.mean * height_weight + time_of_bounce.mean * time_weight + time_to_stop.mean * stop_weight;

% Plot final e
hold on
%yline(e_final);
legend('Height of Bounce','Time To Stop');
hold off
