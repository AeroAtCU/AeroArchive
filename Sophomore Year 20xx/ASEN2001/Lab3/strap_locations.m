clearvars; clc; close all
cd D:\Ian\Documents\GitHub\ASEN2001_Lab3

syms x

moments = -0.1627 * x * sqrt(1 - (2*x / 36)^2);
area = -0.1627 * sqrt(1 - (2*x / 36)^2);

centroids = nan(4,1);
forces = nan(4,1);

L = 36;
dL = L/8;
for i = 1:4
    centroids(i) = eval(int(moments,x,(dL*(i-1)), (dL*i)) / int(area,(dL*(i-1)), (dL*i)));
    forces(i) = eval(int(area, x, (dL*(i-1)), (dL*i)));
end
clear i

centroids
forces