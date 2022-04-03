function [DragX, DragY] = calcDrag(icon, c)
% icon = [velX, velY, theta]
% for inputing drag forces directly into variables in one line
vel.x = icon(1);
vel.y = icon(2);
theta = icon(3);

vel.total = sqrt(vel.x^2 + vel.y^2);

f.totalDrag = 0.5*c.drag_coeff*pi*0.8649*(c.d_bottle/2)^2*(vel.total^2);

DragX = f.totalDrag * cos(theta);
DragY = f.totalDrag * sin(theta);
end
