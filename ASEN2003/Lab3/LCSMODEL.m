function [v_mod] = LCSMODEL(r, d, l, theta, w)
% Purpose: implement our model of a train crankshaft
% SHOULD work with both single values and arrays; if not,
% delete all the dots preceeding stars and slashes.
% r - [m] radius of wheel
% d - [m] horiz dist b/n vert shaft and the disk center

beta = asind((d - r .* sind(theta)) ./ l);

v_mod = -1 .* (w * pi / 180) .* r .* ...
    (tand(beta) .* cosd(theta) + sind(theta));
end
