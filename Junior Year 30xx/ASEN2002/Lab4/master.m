clear all; close all; clc;

% Grab data from files
d = parseData();

% Declare constants
aoanames = fieldnames(d);
arrnames = ["ca", "cn", "cl", "cd"];
vnames = ["v_9"; "v_17"; "v_34"];
x_over_c = ( [0; 0.175; 0.35; 0.7; 1.05; 1.4; 1.75; 2.1; 2.8; 3.5; 2.8; 2.1; 1.4; 1.05; 0.7; 0.35; 0.175] / 3.5 );
Y_14.aoa = [-8; -4; -2; 0; 2; 4; 8; 12; 16; 18; 20;]; % Straight off NACA
Y_14.cl = [-0.1; 0.2; 0.3; 0.5; 0.6; 0.8; 1.1; 1.3; 1.5; 1.6; 1.5;];
Y_14.cd = [1.5; 1.5; 2; 2.5; 3.5; 4.5; 8; 12; 17.5; 21.5; 27] / 100;

% Calculate ca, cn, cl, cd.
for i = 1:length(aoanames)
    name = aoanames{i};
    d.(name) = calccacn(d.(name));
    d.(name) = calcclcd(d.(name));
end

% Create new struct to hold single values for each ca etc for each V
% Makes plotting simpler
for m = 1:length(vnames)
    for i = 1:length(aoanames)
        for j = 1:length(arrnames)
            vd.(vnames{m}).(arrnames{j})(i,1) = d.(aoanames{i}).(vnames{m}).(arrnames{j});
            vd.(vnames{m}).aoa(i,1) = d.(aoanames{i}).AOA(1);
end; end; end        

% ONLY RUN THIS ONCE! More times will sort it incorrectly.
% Yes, this is bad way to do this. Running multiple times *shouldn't* mess
% it up as long as you re-calcualte the indices but that didn't work.
[aoa_srtd, aoa_srtd_indi] = sort(vd.v_17.aoa);
for m = 1:length(vnames)
	for j = 1:length(arrnames)
            vd.(vnames{m}).(arrnames{j}) = vd.(vnames{m}).(arrnames{j})(aoa_srtd_indi);
            vd.(vnames{m}).aoa = aoa_srtd;
end; end

% ------------ Plots (Cp, % chord) ------------------ %

% V = 34, AOA = 6
for j = 1:17
    ex_cp_data(j,1) = mean( d.aoa_pos6.v_34.(strcat('cp',num2str(j)))(:));
end
figure; hold on
plot(x_over_c, ex_cp_data, '.-r', 'LineWidth', 2)
plot([x_over_c(end), x_over_c(1)], [ex_cp_data(end), ex_cp_data(1)], '.-r', 'LineWidth', 2);
plot([0 1], [0 0], 'k', 'LineWidth', 1);
set(gca, 'YDir','reverse')
xlabel('x/c')
ylabel('Cp')
title({'x/c vs Coefficient of Pressure', '(V = 34, AOA = 6)'}) % AOA = 10 originally

% V = 17, AOA = 6
for j = 1:17
    ex_cp_data(j,1) = mean( d.aoa_pos6.v_17.(strcat('cp',num2str(j)))(:));
end
figure; hold on
plot(x_over_c, ex_cp_data, '.-r', 'LineWidth', 2)
plot([x_over_c(end), x_over_c(1)], [ex_cp_data(end), ex_cp_data(1)], '.-r', 'LineWidth', 2);
plot([0 1], [0 0], 'k', 'LineWidth', 1);
set(gca, 'YDir','reverse')
xlabel('x/c')
ylabel('Cp')
title({'x/c vs Coefficient of Pressure', '(V = 17, AOA = 6)'})

% V = 17, AOA = 12
for j = 1:17
    ex_cp_data(j,1) = mean( d.aoa_pos12.v_17.(strcat('cp',num2str(j)))(:));
end
figure; hold on
plot(x_over_c, ex_cp_data, '.-r', 'LineWidth', 2)
plot([x_over_c(end), x_over_c(1)], [ex_cp_data(end), ex_cp_data(1)], '.-r', 'LineWidth', 2);
plot([0 1], [0 0], 'k', 'LineWidth', 1);
set(gca, 'YDir','reverse')
xlabel('x/c')
ylabel('Cp')
title({'x/c vs Coefficient of Pressure', '(V = 17, AOA = 12)'})

% ------------ Plots (cl, cd, AOA) ------------------ %

% AOA vs Lift Coefficient
figure; hold on
plot(vd.v_9.aoa, vd.v_9.cl, '*-k');
plot(vd.v_17.aoa, vd.v_17.cl, '*-b');
plot(vd.v_34.aoa, vd.v_34.cl, '*-r');
plot(Y_14.aoa, Y_14.cl, 'o-m'); % Compare NACA data to our own
title('AOA vs Lift Coefficient');
xlabel('AOA')
ylabel('Cl')
legend('V = 9', 'V = 17', 'V = 34', 'V = 24 (NACA)', 'Location','southeast');

% Lift Coefficient vs Drag Coefficient
figure; hold on
plot(vd.v_9.cl, vd.v_9.cd, '*-k');
plot(vd.v_17.cl, vd.v_17.cd, '*-b');
plot(vd.v_34.cl, vd.v_34.cd, '*-r');
title('Lift Coefficient vs Drag Coefficient');
xlabel('Cl')
ylabel('Cd')
legend('V = 9', 'V = 17', 'V = 34');

% AOA vs Drag Coefficient
figure; hold on
plot(vd.v_9.aoa, vd.v_9.cd, '*-k');
plot(vd.v_17.aoa, vd.v_17.cd, '*-b');
plot(vd.v_34.aoa, vd.v_34.cd, '*-r');
plot(Y_14.aoa, Y_14.cd, 'o-m'); % Compare NACA data to our own
title('AOA vs Drag Coefficient');
xlabel('AOA')
ylabel('Cd')
legend('V = 9', 'V = 17', 'V = 34', 'V = 24 (NACA)', 'Location','southeast');

% ------------ Plots (CP vs V) ------------------ %

figure; hold on; title('CP vs V (AOA = 0)'); xlabel('V (m/s)'); ylabel(strcat('Cp1', ' (Pa)')); % Just trying to get it done now.
plot([9, 17], [mean(d.aoa_pos0.v_9.cp1), mean(d.aoa_pos0.v_17.cp1)], '*-k')
plot([17, 34], [mean(d.aoa_pos0.v_17.cp1), mean(d.aoa_pos0.v_34.cp1)] ,'*-k')
