function y_t = compute_NACA_values(x, c, XX)
% Author: Ian Adler
% Collaborators:
% Date: 01 Feb 2021

% Purpose: Return half thickness (centerline to surface) length of NACA00xx
% given an x value or vector of x values (distance along airfoil)

% x: value or vector of desired components
% t: xx value
% c: chord length
t = XX/100; % NACA00XX value -> percentage of chord
y_t = (t*c/0.2)*(...
    0.2969 * sqrt(x / c) - ...
    0.1260 * x / c - ...
    0.3516 * (x / c).^2 + ...
    0.2843 * (x / c).^3 - ...
    0.1036 * (x / c).^4 ...
    );
end