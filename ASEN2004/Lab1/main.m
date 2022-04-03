% Main
% what glide ratio would you need to reach orbit?
close all;
t = get_tempest_characteristics();

% Calculate C_D and C_L for the entire aircraft
C_D_aircraft = compute_C_D();
C_L_aircraft = t.C_L; % how can this be right??

% Comppute Drag for the 3D wing
C_D_wing = min(t.MH32_2D(:,3)) + (t.C_L .^2) / (pi * t.AR * 0.9);
C_L_wing = t.C_L;

figure;
hold on;
plot(C_L_aircraft, C_D_aircraft)
plot(C_L_aircraft, C_D_wing)
plot(t.CFD(1:14,2), t.CFD(1:14,3))

legend('Computed Whole Aircraft', 'Computed 3D Wing', 'CFD')
xlabel('C_L')
ylabel('C_D')

%% C/D graphs
CL_CD_aircraft = C_L_aircraft ./ C_D_aircraft;
CL_CD_wing = C_L_wing ./ C_D_wing;
CL_CD_CFD = t.CFD(1:14,2) ./ t.CFD(1:14,3);

figure;
hold on;
plot(t.AOA, CL_CD_aircraft)
plot(t.AOA, CL_CD_wing)
plot(t.AOA, CL_CD_CFD)

legend('Computed Whole Aircraft', 'Computed 3D Wing', 'CFD')
xlabel('AOA')
ylabel('C_L / C_D')
