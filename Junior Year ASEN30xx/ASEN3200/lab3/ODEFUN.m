function results = ODEFUN(inputvec, c)
% inputvec = [pos.x; vel.x; pos.y; vel.y; m]

x_pos = inputvec(1);
x_vel = inputvec(2);
y_pos = inputvec(3);
y_vel = inputvec(4);

a = f/m

r = norm(xpos, ypos);
F = Gm/r^2

v = sqrt(G*M / r)

results = [x_vel; x_acc; y_vel; y_acc];

end