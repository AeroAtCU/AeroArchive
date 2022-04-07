% function safe = is_safe(h_start)
h_start = 100; % pretend we dropped like 25 m
start_pos = [0, 0, 0];
start_v = [1, 0, 1];

% FOS = 1.5 => allowable G's "up" = 4G
% for a cirlce of radius R, a = V^2 / R
% gravity factors in only "sideways", lateral w/ FOS = 2G so 

% store information
pos_arr = nan(100, 3); % x, y, z,
vel_arr = nan(100, 3); % v_x, v_y, v_z

speed = calc_speed(h_start);

t_step = 50;
t = 0;

% helix, for example
syms x(time) y(time) z(time)
x(time) = start_v(1) * time + start_pos(1);
y(time) = 0 + start_pos(2);
z(time) = start_v(3) * time - (0.5 * 9.81 * time^2) + start_pos(3);

for incr = 1:200
    % get new position
    pos_arr(incr,:) = [x(t), y(t), z(t)];
    vel_arr(incr,:) = [x(t + t_step) - x(t), ...
                       y(t + t_step) - y(t), ...
                       z(t + t_step) - z(t)];
    
        
    t = t + t_step;
end
disp("plotting");
plot3(pos_arr(:,1),pos_arr(:,2),pos_arr(:,3))

disp("done");
