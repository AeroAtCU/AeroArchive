clear all; clc; close all;
% Surface Treatment
alpha_white = 0.17; % absorptivity of white paint for radiator wall
alpha_black = 0.54; % absorptivity of remaining black walls
epsilon_white = 0.92; % emissivity of white paint for radiator wall
epsilon_black = 0.75; % emissivity of remaining black walls

% Power
P = 20; % on-board instrument power draw (when operational) in [W]

% Orbit
earth_rad = 33; % Earth's thermal radiation in [W/m^2] at all times

% Operational Thermal Requirements
temp_max = 30 + 273; % maximum instrument temp (for operational mode) in [deg K]
temp_min = 15 + 273; % minimum instrument temp (for operational mode) in [deg K]
temp_min_abs = -40 + 273; % min temp of instrument (for survival mode) in [deg K]

As = 0.1588; % m^2, total SA
sigma =5.67 * 10^-8; % Boltzman w/m^4

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
season.marker = "s";

% Pick the correct season. is there a better way...?
switch season.marker
    case {'w', 'winter'}, season.Isun = 1.3278 * 10^3;
    case {'s', 'summer'}, season.Isun = 1.4196 * 10^3;
    case {'a', 'v', 'e' 'autumnal', 'vernal', 'equinox'}, season.Isun = 1.3725 * 10^3;
end

% AF has collumns of: [u b r s1 s2 s3]
[theta, season.AF] = get_area_factor(season.marker);
season.Afr = season.AF(:,3); % radiator values
season.Afo = sum(season.AF, 2) - season.Afr; % all other values

season.qdot_sun = season.Isun*(...
    alpha_white * (1/6) * season.Afr + ...
    alpha_black * (1/6) * season.Afo); % afo - other

% Might need to be a 5/6 and could fix things?
LHS = (alpha_white * season.Afr * (1/6) * As * season.Isun + ...
    alpha_black * season.Afo * (1/6) * As * season.Isun + ...
    P                                                   + ...
    earth_rad * (1/6) * As * epsilon_black);
RHS = (epsilon_white * sigma * (1/6) * As                  + ...
    epsilon_black * sigma * (5/6) * As                  ); % This is just a number so no need to ./

season.T_unheated = (LHS / RHS) .^ (1/4);

season.P_heater = (RHS .* temp_min^4) - LHS;
season.P_heater = season.P_heater .* (season.T_unheated < temp_min);


% season.T_to_heat = -(season.T_unheated - temp_min);
% season.T_to_heat(season.T_to_heat<0) = NaN;


figure; title('Spacecraft Temperatures'); hold on;
plot(theta*24/360, season.T_unheated); %cheap but works (time)
ylabel('Temp [K]'); xlabel('Time [hr]');
legend("Unheated", "Heater Temp");

figure; title('Heater Power Draw');
plot(theta*24/360, season.P_heater);
ylabel("Power Draw [W]"); xlabel("Time [hr]");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if false
   
    
    figure;
    sgtitle('Area Factor on Each Face for Each Critical Day vs. Time')
    
    for i = 1:min(size(season.AF))
        subplot(1,3,1); hold on;
        plot(theta, season.AF(:,i))
    end
    title('Winter Solstice'); xlabel('Time [hr]'); ylabel('Area Factor'); % Labeling
    legend('Upper Face','Bottom Face','Radiator','S1','S2','S3')
    ylim([0,1.1])
    

    for i = 1:min(size(summer.AF))
        subplot(1,3,2); hold on;
        plot(theta, summer.AF(:,i))
    end
    title('Summer Solstice'); xlabel('Time [hr]'); ylabel('Area Factor'); % Labeling
    legend('Upper Face','Bottom Face','Radiator','S1','S2','S3')
    ylim([0,1.1])
    
    
    for i = 1:min(size(equinox.AF))
        subplot(1,3,3); hold on;
        plot(theta, equinox.AF(:,i))
    end
    title('Autumnal/Vernal Equinox'); xlabel('Time [hr]'); ylabel('Area Factor'); % Labeling
    legend('Upper Face','Bottom Face','Radiator','S1','S2','S3')
    ylim([0,1.1])

