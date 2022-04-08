function Plot_Airfoil_Flow(c, alpha, V_inf, p_inf, rho_inf, N)
% Ian Adler
% This function calls another function to compute the flow parameters
% and then plots them.

xmin=-10;
xmax=10;
ymin=-5;
ymax=5;
gridpoints=100; % size of SQUARE gridpoint
% Create meshgrid that all flowfield characteristic will be computed at
[x,y]=meshgrid(linspace(xmin,xmax,gridpoints),linspace(ymin,ymax,gridpoints));

% Get data from function with the given inputs. Don't need p, rho b/c cp
data_struct = compute_flowfield_characteristics(c, alpha, V_inf, x, y, gridpoints, N, 'struct');


% Plot stream fuction at levels
figure; hold on; title("Stream Function (psi)")
contourf(x,y,data_struct.stream_matrix,50)
plot([data_struct.x_eval_points(1), data_struct.x_eval_points(end)],[0 0], 'k', 'linewidth', 2)
axis equal
axis([xmin xmax ymin ymax])
ylabel('y [m]')
xlabel('x [m]')

% Plot velocity function at levels
figure; hold on; title("Equipotential Function (phi)")
contourf(x,y,data_struct.equipotential_matrix,50)
plot([data_struct.x_eval_points(1), data_struct.x_eval_points(end)],[0 0], 'k', 'linewidth', 2)
axis equal
axis([xmin xmax ymin ymax])
ylabel('y [m]')
xlabel('x [m]')

% Plot pressure function at levels
figure; hold on; title("Cp Function (Pressure Distribution)")
contourf(x,y,data_struct.cp_matrix,25)
plot([data_struct.x_eval_points(1), data_struct.x_eval_points(end)],[0 0], 'k', 'linewidth', 2)
axis equal
axis([xmin xmax ymin ymax])
ylabel('y [m]')
xlabel('x [m]')
end