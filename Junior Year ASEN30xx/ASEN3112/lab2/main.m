filepath = 'ASEN3112_Truss_FA2020.txt';

% 0lb: 0 (diff from irl)
% 
% 50lb: 0.001862 m
% 
% Shouldn't be this convoluted to import data as a double.
data_table = readtable(filepath);
data_table = data_table(2:end, :);
data_cell = table2array(data_table);

plot(data_cell(:,end), data_cell(:,1));
xlabel('deflection [in]')
ylabel('Load [lb]')
