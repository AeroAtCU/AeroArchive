clearvars; clc; close all
cd D:\Ian\Documents\GitHub\ASEN2001_Lab3

disp('grabbing data');
% Test # // F [N] // a [m] // w [m] // d_f [m]
rawImport = importdata('TestData.xlsx'); % replace 'TestDat.xlsx' with full filepath it it's not working

[bending, shear] = parseData(rawImport);

bending.MFail = calcMfail(bending);
bending.SigmaFail = calcSigmaFail(bending); %stress at failure = F/area
bending.MeanSigmaFail = mean(abs(bending.SigmaFail));

% Calculate bending data every centimeter through the beamn
% data stored like: "bending.d[test number]( x data, moment data)
disp('calculating moment data');
for i = 1:length(bending.testNumber)
    name = strcat('d',bending.testNumber(i));
    for j = 1:100
    bending.(name)(j,1) = j/100;
    bending.(name)(j,2) = findM(bending.a(i), bending.suppF(i), j/100);
    end
end
clear i j 

disp('plotting moment diagrams');
for i = 1:length(bending.testNumber)
    name = strcat('d',bending.testNumber(i));
    figure;
    plot(bending.(name)(:,1), bending.(name)(:,2))
    title(name);
    xlabel('distance through beam (m)');
    ylabel('moment (N)');
end
