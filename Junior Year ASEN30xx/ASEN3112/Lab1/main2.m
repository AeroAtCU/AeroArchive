%main
close all; clear all;

otwex = 'D:\Ian\Documents\classes\ASEN3112\Lab1\otw_data\DAQ-G1G2-OTW.txt';
ctwex = 'D:\Ian\Documents\classes\ASEN3112\Lab1\ctw_data\DAQ-G1G2-CTW.txt';

% Shouldn't be this convoluted to import data as a double.
data_path = otwex
data_table = readtable(data_path);
data_table = data_table(9000:10000, :);
data_cell = table2array(data_table);
data_arr = str2double(data_cell(:,:));

L = 10; %in
phi = deg2rad(data_arr(:,3)); %rad, "Torsional Epsilon"
T = data_arr(:,4);

GJ = T * 10 ./ phi;
GJ_avg = abs(mean(GJ));
disp(strcat("GJ = ", num2str(GJ_avg)))
J = GJ_avg / (3.75*10^6)
GJ_avg

plot(T,phi);
[vals] = polyfit(T, phi, 1);
m = vals(1);
b = vals(2);

T_point = 300;
phi_point = T_point * m + b;

phi1 = T * m + b;
hold on
plot(T,phi1)

GJ_point = T_point * 10 / phi_point;
G_point = GJ_point / (3.75*10^6)
GJ_point

GJa = T * 10 ./ phi1;
GJa_avg = abs(mean(GJ))

figure;
plot(T, GJ)