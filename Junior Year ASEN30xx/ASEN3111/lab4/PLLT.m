function [e, c_L, c_Di] = PLLT(b_span, a0_t, a0_r, c_t, c_r, aero_t, aero_r, geo_t, geo_r, N, theta)
% Ian Adler / April 2021
%{
Purpose: Compute Prandtl Lifting Line Theorem Info
Input Params:
    b, span in feet
    a0_t, cross sectional lift slope in per radian
    c_t, chord at tip in feet
    aero_t, zero lift aoa in deg
    geo_t, geometric aoa in deg
    N, number of odd terms to include
%}
% Questions:
%   wth is alpha(theta), LHS of the PLLt? cross sectional lift slope?
if N==1, e = nan; c_L = nan; c_Di = nan; return; end

if ~exist('theta', 'var') || isempty(theta)
       theta = [1:1:N]'*pi / (2*N);
end

% Calculate the linear variation of each term (after applying the y-theta trans
a0 = a0_r - (a0_r - a0_t)*cos(theta);         % alpha, cross sectional lift slope?
c = c_r - (c_r - c_t)*cos(theta);             % cord
aero = aero_r - (aero_r - aero_t)*cos(theta); % alpha_l=0
geo = geo_r - (geo_r - geo_t)*cos(theta);     % geometric AOA

% Compute and form the matrii
b_matrix = deg2rad(geo) - deg2rad(aero); % alpha = AOA = geo, aero = zero lift aoa
disp(b_matrix)
N_vec = [1:2:2*N - 1];
A = 4*b_span*sin(N_vec.*theta) ./ (a0.*c) +...
    N_vec.*sin(N_vec.*theta) ./ sin(theta);

An = A\b_matrix;

% Compute our final answers
AR = 2*b_span / (c_t + c_r);

delta = 3*(An(2)/An(1))^2; % truncated version, should be similar to sum
% delta = sum(N_vec(2:end)) * (sum(An(2:end)) / An(1))^2
e = (1 + delta)^-1;
c_L = An(1)*pi*AR;
c_Di = c_L^2/(pi*e*AR);
 end
