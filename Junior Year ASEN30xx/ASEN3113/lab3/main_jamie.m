%% ASEN 3113 - Design Lab
% Authors: Jamie Henault
% Date: 04/02/2021
% Team 18: Jamie Henault, Ian Adler, Sarah Martinez, Shreeyash Nadella

clc; clear; close all; % Housekeeping

%% Mission Requirements
% Surface Treatment
alpha_white = 0.17; % absorptivity of white paint for radiator wall
epsilon_white = 0.92; % emissivity of white paint for radiator wall
alpha_black = 0.54; % absorptivity of remaining black walls
epsilon_black = 0.75; % emissivity of remaining black walls

% Power
P = 20; % on-board instrument power draw (when operational) in [W]

% Inclination
i = 23.5; % inclination in degrees

% Orbit
earth_rad = 33; % Earth's thermal radiation in [W/m^2] at all times

% Operational Thermal Requirements 
temp_max = 30; % maximum instrument temp (for operational mode) in [deg C]
temp_min = 15; % minimum instrument temp (for operational mode) in [deg C]

% Survival thermal requirements
temp_min_abs = -40; % min temp of instrument (for survival mode) in [deg C]


%% Week 1 Part 2
R_summer = 152.1e9;
R_winter = 147.1e9;
R_equinox = 149.6e9;

P_sun = 3.86e26; 

I_summer = P_sun/(4*pi*R_summer^2);
I_winter = P_sun/(4*pi*R_winter^2);
I_equinox = P_sun/(4*pi*R_equinox^2);

get_area_factor('S')
get_area_factor("S")
get_area_factor('s')
get_area_factor("s")


%% Week 2 Part 1
% Winter solstice
theta = 0:0.1:360;

% Winter 
u_w = zeros(1,length(theta));
b_w = sind(i)*ones(1,length(theta));
s1_w = cosd(i).*cosd(theta);
r_w = sind(theta);
s2_w = -sind(theta);
s3_w = -cosd(i).*cosd(theta);

% Summer
u_s = sind(i)*ones(1,length(theta));
b_s = zeros(1,length(theta));
s1_s = cosd(i).*cosd(theta);
r_s = sind(theta);
s2_s = -sind(theta);
s3_s = -cosd(i).*cosd(theta);

% Equinox
u_av = zeros(1,length(theta));
b_av = zeros(1,length(theta));
s1_av = cosd(theta);
r_av = cosd(i).*sind(theta);
s2_av = -cosd(i).*sind(theta);
s3_av = -cosd(theta);

eclipseTime = (17.4/360)*24; % Time of eclipse in [hrs]

time = linspace(0,24,length(theta));

for j = 1:length(time)
    if time(j) < 12 + eclipseTime/2 && time(j) > 12 - eclipseTime/2
        u_av(j) = 0;
        b_av(j) = 0;
        s1_av(j) = 0;
        r_av(j) = 0;
        s2_av(j) = 0;
        s3_av(j) = 0; 
    end
end
        
figure()
sgtitle('Area Factor on Each Face for Each Critical Day vs. Time')

subplot(1,3,1)
plot(time,u_w); hold on;
plot(time,b_w);
plot(time,r_w);
plot(time,s1_w);
plot(time,s2_w);
plot(time,s3_w); hold off;
title('Winter Solstice'); xlabel('Time [hr]'); ylabel('Area Factor'); % Labeling
legend('Upper Face','Bottom Face','Radiator','S1','S2','S3')
ylim([0,1.1])

subplot(1,3,2)
plot(time,u_s); hold on;
plot(time,b_s);
plot(time,r_s);
plot(time,s1_s);
plot(time,s2_s);
plot(time,s3_s); hold off;
title('Summer Solstice'); xlabel('Time [hr]'); ylabel('Area Factor'); % Labeling
legend('Upper Face','Bottom Face','Radiator','S1','S2','S3')
ylim([0,1.1])

subplot(1,3,3)
plot(time,u_av); hold on;
plot(time,b_av);
plot(time,r_av);
plot(time,s1_av);
plot(time,s2_av);
plot(time,s3_av); hold off;
title('Autumnal/Vernal Equinox'); xlabel('Time [hr]'); ylabel('Area Factor'); % Labeling
legend('Upper Face','Bottom Face','Radiator','S1','S2','S3')
ylim([0,1.1])