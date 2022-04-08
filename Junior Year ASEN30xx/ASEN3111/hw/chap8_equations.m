clc; clear all; close all;
gamma = 1.4;
R = 8.31446; % gas constant
M1 = 2.6;
p1 = 1;
T1 = 288; %K
cp = 1.004; % metric or whatever

% Declare functions
rho_from_p_T = @(p, T, R) p/(R*T);
p2_over_p1 = @(M1, gamma)     (1 + (2*gamma / (gamma+1)) * (M1^2-1));
T2_over_T1 = @(M1, gamma)     (1 + (2*gamma / (gamma+1)) * (M1^2-1)) * ((2+(gamma-1)*M1^2) / ((gamma+1)*M1^2));
rho2_over_rho1 = @(M1, gamma) ((gamma+1)*M1^2) / (2 + (gamma-1)*M1^2);
M2_from_M1 = @(M1, gamma)            sqrt((1 + ((gamma-1) / 2) * M1^2) / (gamma*M1^2 - (gamma-1)/2));


T0_over_T = @(M, gamma)      (1 + (gamma-1)*M/2);
rho0_over_rho = @(M, gamma)  ((1 + (gamma-1)*M^2/2))^(gamma/(gamma-1));
p0_over_p = @(M, gamma)      ((1 + (gamma-1)*M^2/2))^(gamma/(gamma-1));

delta_s_from_M1 = @(M1, gamma, cp) cp*log(...
        ((1 + (2*gamma / (gamma+1)) * (M1^2-1)) * ...
        (2+(gamma-1)*M1^2) / ((gamma+1)*M1^2))) - ...
    R*log(1 + 2*gamma*(M1^2 -1 ) / (gamma+1));

a_from_T = @(T, gamma, R) sqrt(gamma*R*T);
%%
% Compute stuff for Anderson 8.7
clc;
p2 = p1 * p2_over_p1(M1, gamma)
T2 = T1 * T2_over_T1(M1, gamma)

rho1 = rho_from_p_T(p1, T1, R)
rho2 = rho1 * rho2_over_rho1(M1, gamma)

M2 = M2_from_M1(M1, gamma)

p0_2 = p2 * p0_over_p(M2, gamma)
T0_2 = T2 * T0_over_T(M2, gamma)

delta_s = delta_s_from_M1(M1, gamma, cp)

%%
% compute stuff for Anderson 8.11
clc; gamma = 1.4;
p1 = 1; T1 = 288; M1 = 0.8331112857; %by hand
M2 = M2_from_M1(M1, gamma)
T2 = 288 * T2_over_T1(M1, gamma)



a2 = a_from_T(T2, gamma, 287)
V = a2*M2
%{
if exist('p1', 'var')
    p2 = p1 * (1 + (2*gamma / (gamma+1)) * (M1^2-1))
end

if exist('T1', 'var')
    T2 = T1 * (1 + (2*gamma / (gamma+1)) * (M1^2-1)) * ((2+(gamma-1)*M1^2) / ((gamma+1)*M1^2))
end

if exist('p1','var') && exist('T1','var')
    rho1 = p1/(R*T1)
end

if exist('rho1', 'var')
    rho2 = rho1*(((gamma+1)*M1^2) / (2 + (gamma-1)*M1^2))
end

rho2_alt = p2/(R*T2)

M2 = sqrt((1 + ((gamma-1) / 2) * M1^2) / (gamma*M1^2 - (gamma-1)/2))
%}