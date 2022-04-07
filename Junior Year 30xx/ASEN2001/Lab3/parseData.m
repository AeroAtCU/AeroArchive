function [bending, shear] = parseData(dataInput)

% Test # // F [N] // a [m] // w [m] // d_f [m]
% Shear: 1, 2, 5, 10, 14, 20
% Must be backwards so that as you delete rows the index below doesn't change
shearLocations = [20,14,10,5,2,1];

shear.data = NaN(length(shearLocations), 5);
bending.data = dataInput.data();

for i = 1:length(shearLocations)
    shear.data(i,:) = dataInput.data(shearLocations(i),:);
    bending.data(shearLocations(i),:) = [];
end

shear.data = flipud(shear.data);

bending.testNumber = string(bending.data(:,1));
bending.F = bending.data(:,2);
bending.a = bending.data(:,3);
bending.w = bending.data(:,4);
bending.d_f = bending.data(:,5);

% haven't done shear yet
shear.testNumber = string(bending.data(1,:));
shear.F = shear.data(1,:);
shear.a = shear.data(1,:);
shear.w = shear.data(1,:);
shear.d_f = shear.data(1,:);

bending.suppF = bending.F ./ 2;
shear.suppF = shear.F ./ 2;

shear = rmfield(shear,'data');
bending = rmfield(bending,'data');
end