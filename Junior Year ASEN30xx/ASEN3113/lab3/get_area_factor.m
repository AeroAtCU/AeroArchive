function [theta, AF] = get_area_factor(condition, theta, i)
% Optional arguments if you want to change inclination (default 23.5deg)
if ~exist('i', 'var') || isempty(i)
    i = 23.5;
end

% Optional argument if you want ot change theta (default collumn vec 0->360
if ~exist('theta', 'var') || isempty(theta)
    theta = [0:0.1:360]';
end

switch lower(condition)
    case {'s', 'summer'}
        u = max(0, sind(i)*ones(size(theta))); % Never changes
        b = max(0, zeros(size(theta))); % Never sees sun
        s1 = max(0, cosd(i).*cosd(theta));
        r = max(0, sind(theta));
        s2 = max(0, -sind(theta));
        s3 = max(0, -cosd(i).*cosd(theta));
        
    case {'w', 'winter'}
        u = max(0, zeros(size(theta))); % Never sees sun
        b = max(0, sind(i)*ones(size(theta))); % Never changes
        s1 = max(0, cosd(i).*cosd(theta));
        r = max(0, sind(theta));
        s2 = max(0, -sind(theta));
        s3 = max(0, -cosd(i).*cosd(theta));
        
    case {'a', 'v', 'e' 'autumnal', 'vernal', 'equinox'}
        u = max(0, zeros(size(theta))); % Never sees sun
        b = max(0, zeros(size(theta))); % Never sees sun
        s1 = max(0, cosd(theta));
        r = max(0, cosd(i).*sind(theta));
        s2 = max(0, -cosd(i).*sind(theta));
        s3 = max(0, -cosd(theta));
        
        % Take care of the eclipse 
        eclipseTime = (17.4/360)*24; % Time of eclipse in [hrs]
        
        time = linspace(0,24,length(theta));
        
        for j = 1:length(time)
            if time(j) < 12 + eclipseTime/2 && time(j) > 12 - eclipseTime/2
                u(j) = 0;
                b(j) = 0;
                s1(j) = 0;
                r(j) = 0;
                s2(j) = 0;
                s3(j) = 0;
            end
        end
        
end

% Format output
AF = [u, b, r, s1, s2, s3];
% u = upper
% b = bottom
% r = radiator
% s3 == nadir
% s2 == "bow"
% s1 == opposite nadir
end
