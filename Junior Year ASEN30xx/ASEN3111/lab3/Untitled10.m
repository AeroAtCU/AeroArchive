clc; clear all;
i = 12
[x, y] = compute_NACA_points(0012, 1, i);
    [cl, cp, tmp] = Vortex_Panel(x, y, nan, 5);
    [clh, cph, tmph] = vp(x, y, 5);


cp = cp/100;
figure; hold on;
plot(x(1:end-1), cp, 'r');
plot(x(1:end-1),real(cph), 'b');
% 310 410 510
