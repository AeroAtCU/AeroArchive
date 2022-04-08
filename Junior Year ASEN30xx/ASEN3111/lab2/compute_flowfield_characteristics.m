function output = compute_flowfield_characteristics(c, AOA_deg, v_inf, x, y, gridpoints, N, output_type)
% Ian Adler
% this function takes as input a matrix on which to compute values, and
% some physical parameters of the flow. It them compute the resulting psi,
% phi, and cp values at each x,y point with an implementation of the given
% gamma equation.

AOA = deg2rad(AOA_deg);
delta_x = c/N;

psi_uniform = v_inf*cos(AOA)*y - v_inf*sin(AOA)*x;
phi_uniform = v_inf*cos(AOA)*x + v_inf*sin(AOA)*y; % either plus or minus

x_eval_points = linspace(0,(c - delta_x),N) + (delta_x / 2); % eval @ midpoints

gamma_vec = 2*AOA*v_inf*sqrt((1 - x_eval_points./c) ./ (x_eval_points/c));

% optimize this later
psi_airfoil = zeros(gridpoints);
phi_airfoil = zeros(gridpoints);

% Sum all airfoils
for i = 1:length(gamma_vec)
    psi_airfoil = psi_airfoil + (gamma_vec(i) * delta_x / (4 * pi)) * log((x - x_eval_points(i)).^2 + y.^2);
    phi_airfoil = phi_airfoil + (-((gamma_vec(i) * delta_x / (2*pi))) * atan2(-y, -(x - x_eval_points(i))));
end

stream_matrix = psi_uniform + psi_airfoil;
equipotential_matrix = phi_uniform + phi_airfoil; % Velocity function // field

% ----- Compute pressure coefficients ------
% cp = 1 - (V/V_inf)^2 from lecture 6
% Computing V:
[v_x, v_y] = gradient(stream_matrix, abs(x(1,2)-x(1,1)), abs(y(1,1)-y(2,1)));
v_mag = sqrt(v_x.^2 + v_y.^2);
cp_matrix = 1 - (v_mag / v_inf) .^2;

output.stream_matrix = stream_matrix;
output.equipotential_matrix = equipotential_matrix;
output.cp_matrix = cp_matrix;
output.x_eval_points = x_eval_points;
output.v_mag = v_mag;

end