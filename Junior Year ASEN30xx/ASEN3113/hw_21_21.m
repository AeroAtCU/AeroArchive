% Problem 21-21
% Ian Adler
clc; close all; clear all;

C1 = 3.74177*10^8; % [W*um^4/m^2]
C2 = 1.43878*10^4; % [um*K]
T = 5780; % [K]

wavelength = linspace(0.01,1000,10^7)'; % [um]
    
E_blackbody = C1 ./ ((wavelength.^5) .*...
    (exp(C2./(wavelength*T)))-1);

figure; hold on;
title('Emissive Power vs. Wavelenegth @ 5780K')
xlabel(' LOG10(Wavelength) [{\mu}m]')
ylabel(' Emissive Power E_{\lambda} [W / m^{2}{\mu}m]')
plot(log10(wavelength),(E_blackbody), '.', 'markersize',3);



















%wavelength = linspace(1.2589,1000,10^7)'; % [um]

% for i = 1:length(wavelength)
%     
%     lambda = wavelength(i);
%     E_blackbody(i) = C1 / (lambda^5 * (exp(C2/(lambda*T))-1));
% end
% 
% figure;
% loglog(wavelength,E_blackbody, '.', 'markersize',3);
    