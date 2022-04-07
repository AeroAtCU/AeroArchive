function ret_struct = parabola_section(pos_i, vel_i)
% Input: initial position, initial velocity vectors
% Output: struct containing information about the flight path
%   ret_struct.pos_arr = array of positions, each row is a t_step and
%       each col is x|y|z position
%   ret_struct.vel_f = the final velocity vector (assumed to be inital
%       velocity vector with z position flipped, b/c parabolic arc
%   ret_struct.t = time to complete path.

% Assume some initial conditions if no inputs are given
if (nargin ~= 2)
    pos_i = [0, 0, 0];
    vel_i = [24.78, 0, 24.78];
end

% Declare functions (kinematic equations, g in z dir)
syms x(time) y(time) z(time)

% Declare position functions
s_x(time) = vel_i(1) * time + pos_i(1);
s_y(time) = vel_i(2) * time + pos_i(2);
s_z(time) = vel_i(3) * time - (0.5 * 9.81 * time^2) + pos_i(3);

% Declare velocity functions
v_z(time) = vel_i(3) - 9.81 * time;

% Declare necesary constants 
t_step = 0.1;
t = 0;
arr_init_size = 200;

% Declare arrays to hold output
pos_arr = nan(arr_init_size,3);
vel_arr = nan(arr_init_size,3);
time_arr = nan(arr_init_size,1);

% Loop through the length of pos_arr, calculating the position at each
% time incremented by time_step. Stop calculating once z had returned
% to it's original height
for i = 1:length(pos_arr(:,1))
    % populate pos, vel, and time arrays
    pos_arr(i,:) = [s_x(t), s_y(t), s_z(t)];
    vel_arr(i,:) = [vel_i(1), vel_i(2), v_z(t)];
    time_arr(i) = t;
    
    % increment time
    t = t + t_step;
    
    % stop computation once z pos is at or below it's initial pos
    if ((s_z(t) <= pos_i(3)))
        break
    end
end

% Give a warning if pos_arr isn't big enough to hold all the values
if (i >= arr_init_size)
    warning("In parabola_section, pos_arr is full. Consider increasing it's size or changing it to a while loop")
end

% Remove any unused rows
pos_arr((i + 1):end, :) = [];
vel_arr((i + 1):end, :) = [];
time_arr((i + 1):end) = [];

% Create the return struct (access these with var_name.item_name)
ret_struct.pos_arr = pos_arr;
ret_struct.vel_arr = vel_arr;
ret_struct.time_arr = time_arr;
ret_struct.vel_f = vel_arr(end,:);
ret_struct.total_time = t;
end