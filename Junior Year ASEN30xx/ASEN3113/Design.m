%% Design Lab
% group 25

%% 
clear
clc
close all
tic

%% constants 
sigma = 5.67E-8; % W/(m^2 K^4)
alphaSun = .2;
alpha = .85;
eps = alpha;

Gsun = 1361;    % W/m^2

Tmax = 30 + 273;    % C to K
Tmin = 20 + 273;    % C to K
Tsurv = -40 + 273;  % C to K

WInst = 20;   % W
IRwinter = 63; % W/m^2
IRsummer = 88; % W/m^2
IReclipse = 11; % W/m^2
IRequinox = (IRwinter+IRsummer)/2; % W/m^2

e = 0.0167;
Rwinter = (1-e);
Rsummer = (1+e);
Requinox = 1;

incl = 23.5;

time = 0:1:24;

theta = linspace(0, 2*pi, 10*length(time));


%% find radiator area

Asum = 20 / ( (eps*sigma*Tmax^4) - (alphaSun*Gsun*((1./Rsummer)^2)*cosd(incl)) - (alpha*IRsummer) );
Awinter = 20 / ( (eps*sigma*Tmax^4) - (alphaSun*Gsun*(1/Rwinter)^2*cosd(incl)) - (alpha*IRwinter) );
Aeq = 20 / ( (eps*sigma*Tmax^4) - (alphaSun*Gsun*(1/Requinox)^2) - (alpha*IRequinox) );

Arad = max([Asum Awinter Aeq]);

%% solar flux
% no instrument or IR 

for i = 1:length(theta)
    if ((theta(i) > 0) && (theta(i) < pi))
        fluxWinter(i) = alphaSun*Gsun*((1/Rwinter)^2)*Arad*sin(theta(i))*cosd(incl);
        fluxSummer(i) = alphaSun*Gsun*((1/Rsummer)^2)*Arad*sin(theta(i))*cosd(incl);
    else
        fluxWinter(i) = 0;
        fluxSummer(i) = 0;
    end
end

eclipse = atan(1/6.62);

for i = 1:length(theta)
    if ((theta(i) > 0) && (theta(i) < pi-eclipse))
        fluxEquinox(i) = alphaSun*Gsun*((1/Requinox)^2)*Arad*sin(theta(i));
    else
        fluxEquinox(i) = 0;
    end
end

figure(1)
hold on
plot(theta, fluxEquinox, '-', 'linewidth', 2)
plot(theta, fluxWinter, '-', 'linewidth', 2)
plot(theta, fluxSummer, '-', 'linewidth', 2)
ylabel('Flux [W]')
xlabel('Time')
xticks([0 pi/2 pi 3*pi/2 2*pi])
xticklabels({'Noon','Dusk','Midnight','Dawn','Noon'})
xlim([0 2*pi])

title('Solar Flux Aborbed Over 24 hrs')
legend('Equinox', 'Winter', 'Summer')
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)




%% Winter Temp

baseW = (fluxWinter) + (WInst) + (alpha*Arad*IRwinter);

TNANw = ( baseW./(eps.*sigma.*Arad) ).^.25; % no power
indOP = find(TNANw <= 20+273);

powerOPw = zeros(1, length(theta));
powerOPw(indOP) = eps.*sigma.*Arad.*(Tmin).^4 - baseW(indOP);
TOPw = ( (baseW+powerOPw)./(eps.*sigma.*Arad) ).^.25; % operational power

survW = (fluxWinter) + (alpha*Arad*IRwinter);
TSw = ( survW./(eps.*sigma.*Arad) ).^.25; % no power
indSURV = find(TSw <= -40+273);
powerSURVw = zeros(1, length(theta));
powerSURVw(indSURV) = eps.*sigma.*Arad.*(Tsurv).^4 - survW(indSURV);
TSURVw = ( (survW+powerSURVw)./(eps.*sigma.*Arad) ).^.25; % survival power


figure(2)
hold on
yyaxis left
plot(theta, TNANw - 273, '-', 'linewidth', 2, 'color', [0  0.4471  0.7412])
plot(theta, TOPw - 273, '-',  'linewidth', 2, 'color', [0.8510  0.3255  0.0980])
plot(theta, TSURVw - 273, '-', 'linewidth', 2, 'color', [0.9294  0.6941  0.1255])
ylabel('Temperature [°C]')
xlabel('Time')
xticks([0 pi/2 pi 3*pi/2 2*pi])
xticklabels({'Noon','Dusk','Midnight','Dawn','Noon'})
xlim([0 2*pi])

yyaxis right
plot(theta, powerOPw, '--', 'linewidth', 2, 'color', [0.9608  0.4902  0.2863])
plot(theta, powerSURVw, '--', 'linewidth', 2, 'color', [0.9412  0.7569  0.3294])
ylabel('Power')

title('Winter: Temperature and Power Over 24 hrs')
legend('Temp w/ No Power', 'Temp w/ Operational Power', 'Temp w/ Survival Power', 'Operational Power', 'Survival Power', 'location', 'east')
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';


%% summer
% straight up copy and paste from winter

baseS = (fluxSummer) + (WInst) + (alpha*Arad*IRsummer);

TNANs = ( baseS./(eps.*sigma.*Arad) ).^.25; % no power
indOP = find(TNANs <= 20+273);

powerOPs = zeros(1, length(theta));
powerOPs(indOP) = eps.*sigma.*Arad.*(Tmin).^4 - baseS(indOP);
TOPs = ( (baseS+powerOPs)./(eps.*sigma.*Arad) ).^.25; % operational power

survS = (fluxSummer) + (alpha*Arad*IRsummer);
TSs = ( survS./(eps.*sigma.*Arad) ).^.25; % no power
indSURV = find(TSs <= -40+273);
powerSURVs = zeros(1, length(theta));
powerSURVs(indSURV) = eps.*sigma.*Arad.*(Tsurv).^4 - survS(indSURV);
TSURVs = ( (survS+powerSURVs)./(eps.*sigma.*Arad) ).^.25; % operational power


figure
hold on
yyaxis left
plot(theta, TNANs - 273, '-', 'linewidth', 2, 'color', [0  0.4471  0.7412])
plot(theta, TOPs - 273, '-',  'linewidth', 2, 'color', [0.8510  0.3255  0.0980])
plot(theta, TSURVs - 273, '-', 'linewidth', 2, 'color', [0.9294  0.6941  0.1255])
ylabel('Temperature [°C]')
xlabel('Time')
xticks([0 pi/2 pi 3*pi/2 2*pi])
xticklabels({'Noon','Dusk','Midnight','Dawn','Noon'})
xlim([0 2*pi])

yyaxis right
plot(theta, powerOPs, '--', 'linewidth', 2, 'color', [0.9608  0.4902  0.2863])
plot(theta, powerSURVs, '--', 'linewidth', 2, 'color', [0.9412  0.7569  0.3294])
ylabel('Power')

title('Summer: Temperature and Power Over 24 hrs')
legend('Temp w/ No Power', 'Temp w/ Operational Power', 'Temp w/ Survival Power', 'Operational Power', 'Survival Power', 'location', 'east')
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';


%% equinox

IRequinox;
IReclipse;

for i = 1:length(theta)
    if ((theta(i) < pi+eclipse) && (theta(i) > pi-eclipse))
        IREq(i) = IReclipse;
    else
        IREq(i) = IRequinox;
    end
end

baseE = (fluxEquinox) + (WInst) + (alpha.*Arad.*IREq);

TNANe = ( baseE./(eps.*sigma.*Arad) ).^.25; % no power
indOP = find(TNANe <= 20+273);

powerOPe = zeros(1, length(theta));
powerOPe(indOP) = eps.*sigma.*Arad.*(Tmin).^4 - baseE(indOP);
TOPe = ( (baseE+powerOPe)./(eps.*sigma.*Arad) ).^.25; % operational power

survE = (fluxEquinox) + (alpha.*Arad.*IREq);
TSe = ( survE./(eps.*sigma.*Arad) ).^.25; % no power
indSURV = find(TSe <= -40+273);
powerSURVe = zeros(1, length(theta));
powerSURVe(indSURV) = eps.*sigma.*Arad.*(Tsurv).^4 - survE(indSURV);
TSURVe = ( (survE+powerSURVe)./(eps.*sigma.*Arad) ).^.25; % operational power


figure
hold on
yyaxis left
plot(theta, TNANe - 273, '-', 'linewidth', 2, 'color', [0  0.4471  0.7412])
plot(theta, TOPe - 273, '-',  'linewidth', 2, 'color', [0.8510  0.3255  0.0980])
plot(theta, TSURVe - 273, '-', 'linewidth', 2, 'color', [0.9294  0.6941  0.1255])
ylabel('Temperature [°C]')
xlabel('Time')
xticks([0 pi/2 pi 3*pi/2 2*pi])
xticklabels({'Noon','Dusk','Midnight','Dawn','Noon'})
xlim([0 2*pi])

yyaxis right
plot(theta, powerOPe, '--', 'linewidth', 2, 'color', [0.9608  0.4902  0.2863])
plot(theta, powerSURVe, '--', 'linewidth', 2, 'color', [0.9412  0.7569  0.3294])
ylabel('Power')

title('Equinox: Temperature and Power Over 24 hrs')
legend('Temp w/ No Power', 'Temp w/ Operational Power', 'Temp w/ Survival Power', 'Operational Power', 'Survival Power', 'location', 'east')
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';

%% 
toc