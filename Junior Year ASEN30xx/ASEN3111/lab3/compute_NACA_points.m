function [x, y] = compute_NACA_points(XXXX, c, N)
%{
Ian Adler / March 2021
Params:
    c: chord length
    XXXX:
        1st digit == 100m
        2nd digit == 10p
        3-4 digit == 100t
    N: number of panels desired (need ~2N points)

Output:
    x: vector of coordinates describing airfoil geometry
    y: vector of coordinates describing airfoil geometry
%}
x = linspace(0,c,ceil(N/2)+1); % Let's just stick to even N for now ***

% Compute some NACA constants after decomposing XXXX into digits.
m = floor(XXXX/1000) / 100; % DIGIT 1 = 100m
p = floor(mod(XXXX,1000)/100) / 10; % DIGIT 2 = 10p
t = mod(XXXX,100) / 100; % DIGITS 2/5 = 100t

% Compute thickness distribution.
y_t = (t*c/0.2)*(...
    0.2969 * sqrt(x / c) - ...
    0.1260 * x / c - ...
    0.3516 * (x / c).^2 + ...
    0.2843 * (x / c).^3 - ...
    0.1036 * (x / c).^4 ...
    );

% Take care of special case, no camber
if p==0 || m ==0
    y_c = zeros(1,length(x));
    d_y_c_dx = y_c;
    
else
    % I perform the entire operation on both matrii, mask, and sum them.
    % x<=pc gives 1/0 mask of allowed values; sum that with masked x>pc
    y_c = (x<=p*c).*(m*(x / p^2) .* (2*p - x/c)) + ...
        (x>p*c) .*(m*((c-x)/(1-p)^2) .* (1 + x/c - 2*p));
    
    d_y_c_dx = (x<=p*c) .*(2*m*(p - x) / p^2) + ...
        (x>p*c)  .*(2*m*(p-x) / (1-p)^2);
end

% Now compute zeta (after camber/ no camber is taken care of)
zeta = atan(d_y_c_dx);

% Get x positions:
x_u = x - y_t.*sin(zeta);
x_l = x + y_t.*sin(zeta);
y_u = y_c + y_t.*cos(zeta);
y_l = y_c - y_t.*cos(zeta);

% Format output
x = [x_u, flip(x_l)]; % Must flip so last point coinsides with first
y = [y_u, flip(y_l)]; % Effectively draws clockwise starting at 0,0
end