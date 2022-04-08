function drag_force = calcDrag(V, rho, Cd, A)
% (-V/abs(V)) gives opposite direction
drag_force = (-sign(V)) .* rho .* Cd .* A .* 0.5 .* V.^2;
end