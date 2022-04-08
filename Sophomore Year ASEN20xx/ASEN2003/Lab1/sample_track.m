syms x(t)
syms y(t)
syms z(t)

%% helix
disp("starting")
s = [0 0 0]; % s is initial position
x(t) = cos(t) + s(1);
y(t) = sin(t) + s(2);
z(t) = t + s(3);
%fsurf(x, y, z)

end_pos = [x(4*pi) y(4*pi) z(4*pi)];

%% straight down
s = end_pos; % s is initial position

x(t) = 0 + s(1);
y(t) = 0 + s(2);
z(t) = -t + s(3);
%fsurf(x, y, z, [-10 10])

disp("done")
